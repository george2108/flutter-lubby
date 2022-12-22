import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:image_picker/image_picker.dart';
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';
import 'package:lubby_app/src/data/datasources/local/services/images_local_service.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'package:lubby_app/src/data/entities/note_entity.dart';
import 'package:lubby_app/src/presentation/widgets/show_snackbar_widget.dart';

import '../../bloc/notes_bloc.dart';
import '../../widgets/note_change_color_widget.dart';
import '../../widgets/note_input_title_widget.dart';
import '../../widgets/note_popup_widget.dart';
import '../../widgets/note_star_widget.dart';
import '../notes_page.dart';
import 'bloc/note_bloc.dart';

class NotePage extends StatelessWidget {
  final NoteEntity? note;
  final BuildContext notesContext;

  const NotePage({
    Key? key,
    this.note,
    required this.notesContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
        BlocProvider.of<NotesBloc>(notesContext),
        note,
      ),
      child: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state.status == StatusCrudEnum.created) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Nota creada.',
                content: '!La nota ha sido creada exitosamente¡.',
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => const NotesPage()),
              (route) => false,
            );
          }
          if (state.status == StatusCrudEnum.deleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Nota eliminada.',
                content: '!La nota ha sido eliminado exitosamente¡.',
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => const NotesPage()),
              (route) => false,
            );
          }
          if (state.status == StatusCrudEnum.updated) {
            ScaffoldMessenger.of(context).showSnackBar(
              showCustomSnackBarWidget(
                title: 'Nota actualizada.',
                content: '!La nota ha sido actualizada exitosamente¡.',
              ),
            );
          }
        },
        child: const _BuildPage(),
      ),
    );
  }
}

///
/// Build page
///
class _BuildPage extends StatefulWidget {
  const _BuildPage({Key? key}) : super(key: key);

  @override
  State<_BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<_BuildPage> {
  XFile? file;

  Future<void> addImage(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    final imageService = ImagesLocalService();
                    final files = await imageService.getImagesGallery();

                    for (var i = 0; i < files.length; i++) {
                      final file = files[i];
                      if (file?.path != null) {
                        embedImage(file!.path.toString());
                      }
                    }
                    Navigator.of(context).maybePop();
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.image_outlined),
                      Text('Gallery'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final imageService = ImagesLocalService();
                    final file = await imageService.getImageCamera();
                    if (file?.path != null) {
                      embedImage(file!.path.toString());
                    }
                    Navigator.of(context).maybePop();
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.camera_alt_outlined),
                      Text('Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  embedImage(String imageUrl) {
    final block = flutter_quill.BlockEmbed.custom(
      NotesBlockEmbed.saveImage(
        imageUrl,
      ),
    );
    final controller =
        BlocProvider.of<NoteBloc>(context).state.flutterQuillcontroller;
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;
    controller.replaceText(index, length, block, null);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final bloc = BlocProvider.of<NoteBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nota'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
            onPressed: () {
              if (bloc.state.editing) {
                context.read<NoteBloc>().add(NoteUpdatedEvent());
              } else {
                context.read<NoteBloc>().add(const NoteCreatedEvent());
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const NoteStarWidget(),
                      const NoteChangeColorWidget(),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          addImage(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Icon(Icons.add_photo_alternate_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const NotePopupWidget(),
            ],
          ),

          const NoteInputTitleWidget(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: flutter_quill.QuillEditor(
                controller:
                    context.watch<NoteBloc>().state.flutterQuillcontroller,
                scrollController: ScrollController(),
                embedBuilders: [
                  ...FlutterQuillEmbeds.builders(),
                  NotesEmbedBuilder(addImage: addImage),
                ],
                expands: false,
                padding: const EdgeInsets.all(0),
                autoFocus: false,
                readOnly: false,
                focusNode: context.watch<NoteBloc>().state.focusNodeNote,
                scrollable: true,
                placeholder: 'Escribe tu nota aqui...',
                scrollBottomInset: 20,
                scrollPhysics: const BouncingScrollPhysics(),
                onImagePaste: (imageBytes) async {
                  print(imageBytes);
                },
              ),
            ),
          ),
          Visibility(
            visible: keyboardVisible,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(),
                  bottom: BorderSide(),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: flutter_quill.QuillToolbar.basic(
                  controller:
                      context.watch<NoteBloc>().state.flutterQuillcontroller,
                  locale: const Locale('es'),
                  showAlignmentButtons: true,
                  showDividers: true,
                  showDirection: true,
                  showFontFamily: false,
                  showFontSize: false,
                ),
              ),
            ),
          ),
          // const NoteSaveButtonWidget(),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class NotesBlockEmbed extends flutter_quill.CustomBlockEmbed {
  final String value;

  const NotesBlockEmbed(this.value) : super(noteType, value);

  static const String noteType = 'image_notes';

  static NotesBlockEmbed saveImage(String newImageUrl) =>
      NotesBlockEmbed(newImageUrl);

  String get imageUrl => value;
}

////////////////////////////////////////////////////////////////////////////////
class NotesEmbedBuilder implements flutter_quill.EmbedBuilder {
  NotesEmbedBuilder({required this.addImage});

  Future<void> Function(BuildContext context) addImage;

  @override
  String get key => 'image_notes';

  @override
  Widget build(
    BuildContext context,
    flutter_quill.QuillController controller,
    flutter_quill.Embed node,
    bool readOnly,
  ) {
    final image = NotesBlockEmbed(node.value.data).imageUrl;

    return Image.file(
      File(image),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:image_picker/image_picker.dart';

import 'package:lubby_app/src/core/constants/constants.dart';
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';
import 'package:lubby_app/src/data/datasources/local/services/images_local_service.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/data/entities/note_entity.dart';
import 'package:lubby_app/src/ui/widgets/select_label_widget.dart';
import 'package:lubby_app/src/ui/widgets/star_favorite_widget.dart';

import '../bloc/notes_bloc.dart';
import '../widgets/note_change_color_widget.dart';
import '../widgets/note_input_title_widget.dart';
import '../widgets/note_popup_widget.dart';

// ignore: must_be_immutable
class NoteView extends StatefulWidget {
  final NoteEntity? note;
  final BuildContext notesContext;
  const NoteView({super.key, this.note, required this.notesContext});
  @override
  State<NoteView> createState() => _NoteViewState();
}

////////////////////////////////////////////////////////////////////////////////
class _NoteViewState extends State<NoteView> {
  late final List<XFile> files;
  late final StatusCrudEnum status;
  late final bool loading;
  XFile? file;

  late final TextEditingController titleController;
  late final flutter_quill.QuillController flutterQuillcontroller;
  late final FocusNode focusNodeNote;
  late final bool editing;
  bool favorite = false;
  late Color color = kDefaultColorPick;
  LabelEntity? labelSelected;

  bool mostrarOpcionesTexto = false;

  @override
  void initState() {
    super.initState();
    editing = widget.note != null;
    titleController = TextEditingController(text: widget.note?.title ?? '');
    focusNodeNote = FocusNode();
    flutterQuillcontroller = widget.note == null
        ? flutter_quill.QuillController.basic()
        : flutter_quill.QuillController(
            document: flutter_quill.Document.fromJson(
              jsonDecode(widget.note!.body),
            ),
            selection: const TextSelection.collapsed(offset: 0),
          );
    favorite = widget.note?.favorite ?? false;
    color = widget.note?.color ?? kDefaultColorPick;
    labelSelected = widget.note?.label;
  }

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
    final controller = flutterQuillcontroller;
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;
    controller.replaceText(index, length, block, null);
  }

  @override
  void dispose() {
    titleController.dispose();
    flutterQuillcontroller.dispose();
    focusNodeNote.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final bloc = BlocProvider.of<NotesBloc>(widget.notesContext);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nota'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
            onPressed: () {
              final NoteEntity note = NoteEntity(
                id: editing ? widget.note!.id : null,
                title: titleController.text.trim(),
                body: jsonEncode(
                  flutterQuillcontroller.document.toDelta().toJson(),
                ),
                createdAt: DateTime.now(),
                favorite: favorite,
                color: color,
                label: labelSelected,
                labelId: labelSelected?.id,
              );

              if (editing) {
                bloc.add(NoteUpdatedEvent(note));
              } else {
                bloc.add(NoteCreatedEvent(note));
              }
            },
          ),
          NotePopupWidget(note: widget.note),
        ],
      ),
      body: Column(
        children: [
          _toolbar(context, bloc),

          NoteInputTitleWidget(
            titleController: titleController,
            touched: () {
              setState(() {
                mostrarOpcionesTexto = false;
              });
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: flutter_quill.QuillEditor(
                onTapDown: (details, p1) {
                  setState(() {
                    mostrarOpcionesTexto = true;
                  });
                  return false;
                },
                controller: flutterQuillcontroller,
                scrollController: ScrollController(),
                embedBuilders: [
                  ...FlutterQuillEmbeds.builders(),
                  NotesEmbedBuilder(addImage: addImage),
                ],
                expands: false,
                padding: const EdgeInsets.all(0),
                autoFocus: false,
                readOnly: false,
                focusNode: focusNodeNote,
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
            visible: keyboardVisible && mostrarOpcionesTexto,
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
                  controller: flutterQuillcontroller,
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

  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Toolbar con opciones de la nota
  /// favorito, color, imagen, etiquetas
  /// [context] contexto de la app
  /// [bloc] bloc de la capa de negocio de las notas
  ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _toolbar(BuildContext context, NotesBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StarFavoriteWidget(
                  valueInitial: favorite,
                  onStarPressed: (value) {
                    favorite = value;
                  },
                ),
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
                const SizedBox(width: 10),
                NoteChangeColorWidget(
                  colorInitial: color,
                  notesContext: widget.notesContext,
                  onColorChanged: (color) {
                    this.color = color;
                  },
                ),
                const SizedBox(width: 10),
                SelectLabelWidget(
                  labels: bloc.state.labels,
                  labelSelected: labelSelected,
                  onSelected: (labelSelected) {
                    this.labelSelected = labelSelected;
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///
/// Widget que muestra el contenido cuando se agrega una imagen
/// directo a la nota
/// Se encarga de recibir un valor de tipo String que es la ruta de la imagen
/// y mostrarla en pantalla
///
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
///
/// Widget que muestra el contenido cuando se agrega una imagen
/// manda a llamar el metodo addImage para agregar una imagen
/// necesita del notesblockembed para obtener la ruta de la imagen y mostrarla
/// en un widget Image o personalizarlo
///
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

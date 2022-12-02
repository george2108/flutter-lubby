import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';

import 'package:lubby_app/src/data/models/note_model.dart';
import 'package:lubby_app/src/presentation/widgets/button_save_widget.dart';
import 'package:lubby_app/src/presentation/widgets/show_color_picker_widget.dart';
import 'package:lubby_app/src/presentation/widgets/show_snackbar_widget.dart';

import '../notes/bloc/notes_bloc.dart';
import '../notes/notes_page.dart';
import 'bloc/note_bloc.dart';

part 'widgets/note_star_widget.dart';
part 'widgets/note_popup_widget.dart';
part 'widgets/note_save_button_widget.dart';
part 'widgets/note_input_title_widget.dart';
part 'widgets/note_change_color_widget.dart';

class NotePage extends StatelessWidget {
  final NoteModel? note;
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
class _BuildPage extends StatelessWidget {
  const _BuildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nota'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
            onPressed: () {},
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
                      Container(
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
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).splashColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.network(
                          'https://yt3.ggpht.com/ytc/AMLnZu_KHDw6I2WGQm_pMUfjh86nDMTkC1A1DtD1VUYIYg=s900-c-k-c0x00ffffff-no-rj',
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).splashColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.network(
                          'https://i.pinimg.com/originals/08/11/a3/0811a35a1fff5513ee97b3db2e405d18.jpg',
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
                scrollController: ScrollController(),
                expands: false,
                padding: const EdgeInsets.all(0),
                autoFocus: false,
                controller:
                    context.watch<NoteBloc>().state.flutterQuillcontroller,
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

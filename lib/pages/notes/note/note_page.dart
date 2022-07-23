import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;

import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/bloc/note_bloc.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/pages/notes/notes/notes_page.dart';
import 'package:lubby_app/widgets/button_save_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/note_star_widget.dart';
part 'widgets/note_popup_widget.dart';
part 'widgets/note_save_button_widget.dart';

class NotePage extends StatelessWidget {
  final NoteModel? note;
  final BuildContext notesContext;

  NotePage({
    Key? key,
    this.note,
    required this.notesContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
        BlocProvider.of<NotesBloc>(notesContext),
      )..add(NoteInitialEvent(note)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi nota'),
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          actions: [
            const NoteStarWidget(),
            const NotePopupWidget(),
          ],
        ),
        body: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is NoteCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                showCustomSnackBarWidget(
                  title: 'Nota creada.',
                  content: '!La nota ha sido creada exitosamente¡.',
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => NotesPage()),
                (route) => false,
              );
            }
            if (state is NoteDeletedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                showCustomSnackBarWidget(
                  title: 'Nota eliminada.',
                  content: '!La nota ha sido eliminado exitosamente¡.',
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => NotesPage()),
                (route) => false,
              );
            }
            if (state is NoteUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                showCustomSnackBarWidget(
                  title: 'Nota actualizada.',
                  content: '!La nota ha sido actualizada exitosamente¡.',
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NoteLoadedState) {
              return Column(
                children: [
                  _InputTitle(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 5),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: flutterQuill.QuillToolbar.basic(
                        controller: state.flutterQuillcontroller,
                        locale: const Locale('es'),
                        showDividers: true,
                        showImageButton: false,
                        showVideoButton: false,
                        showCameraButton: false,
                        showDirection: true,
                        onImagePickCallback: (file) async {
                          print(file);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: flutterQuill.QuillEditor(
                          scrollController: ScrollController(),
                          expands: false,
                          padding: const EdgeInsets.all(0),
                          autoFocus: false,
                          controller: state.flutterQuillcontroller,
                          readOnly: false,
                          focusNode: state.focusNodeNote,
                          scrollable: true,
                          placeholder: 'Escribe tu nota aqui...',
                          scrollBottomInset: 20,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ),
                  ),
                  const NoteSaveButtonWidget(),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _InputTitle extends StatelessWidget {
  _InputTitle({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: state.titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Titulo de la nota",
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class ItemColorNote extends StatelessWidget {
  final bool selected;
  final int color;

  const ItemColorNote({
    required this.selected,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.black : Colors.transparent,
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Container(
              color: Color(color),
            ),
            Container(
              alignment: Alignment.center,
              child: Visibility(
                visible: selected,
                child: const Icon(Icons.check),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;

import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/bloc/note_bloc.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/pages/notes/notes/notes_page.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/note_star_widget.dart';

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
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Color de nota'),
                  value: 'color',
                ),
              ],
              onSelected: (value) {
                if (value == 'color') {
                  showDialogElegirColor(context);
                }
              },
            ),
          ],
        ),
        body: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is NoteCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                showCustomSnackBarWidget(
                  title: 'Nota creada,',
                  content: '!La nota ha sido creada exitosamente¡.',
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => NotesPage()),
                (route) => false,
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
                  const _SaveNoteButton(),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  showDialogElegirColor(BuildContext context) {
    Color pickerColor = Color(0xff443a49);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Elegir'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    Color currentColor = color;
    print(currentColor);
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

class _SaveNoteButton extends StatelessWidget {
  const _SaveNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadedState) {
          return ArgonButton(
            height: 50,
            width: width,
            child: Text(
              state.editing ? 'Actualizar nota' : 'Crear nota',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            borderRadius: 5.0,
            color: Theme.of(context).buttonTheme.colorScheme!.background,
            loader: Container(
              padding: const EdgeInsets.all(10),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ),
            onTap: (startLoading, stopLoading, btnState) async {
              if (btnState == ButtonState.Idle) {
                startLoading();
                if (state.editing) {
                  context.read<NoteBloc>().add(NoteUpdatedEvent());
                } else {
                  context.read<NoteBloc>().add(NoteCreatedEvent());
                }
                stopLoading();
              }
            },
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

/* var txt = await controller.getText();
                      if (txt.contains('src=\"data:')) {
                        txt =
                            '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                      }
                      setState(() {
                        result = txt;
                      }); */

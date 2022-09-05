import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;
import 'package:lubby_app/core/enums/status_crud_enum.dart';

import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/bloc/note_bloc.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';
import 'package:lubby_app/pages/notes/notes/notes_page.dart';
import 'package:lubby_app/widgets/button_save_widget.dart';
import 'package:lubby_app/widgets/show_color_picker_widget.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

part 'widgets/note_star_widget.dart';
part 'widgets/note_popup_widget.dart';
part 'widgets/note_save_button_widget.dart';
part 'widgets/note_input_title_widget.dart';

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
              CupertinoPageRoute(builder: (_) => NotesPage()),
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
              CupertinoPageRoute(builder: (_) => NotesPage()),
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

class _BuildPage extends StatelessWidget {
  const _BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nota'),
        actions: [
          const NoteStarWidget(),
          NotePopupWidget(),
        ],
      ),
      body: Column(
        children: [
          NoteInputTitleWidget(),
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
                controller:
                    context.watch<NoteBloc>().state.flutterQuillcontroller,
                locale: const Locale('es'),
                showDividers: true,
                showImageButton: false,
                showVideoButton: false,
                showCameraButton: false,
                showDirection: true,
                onImagePickCallback: (file) async {
                  print(file);
                  return file.toString();
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
                  controller:
                      context.watch<NoteBloc>().state.flutterQuillcontroller,
                  readOnly: false,
                  focusNode: context.watch<NoteBloc>().state.focusNodeNote,
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
      ),
    );
  }
}

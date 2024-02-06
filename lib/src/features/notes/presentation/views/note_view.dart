import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../../injector.dart';
import '../../../../core/constants/responsive_breakpoints.dart';
import '../../../../core/enums/status_crud_enum.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../../core/utils/utc_date.dart';
import '../../../../data/datasources/local/images_local_service.dart';
import '../../entities/note_entity.dart';
import '../../repositories/note_repository.dart';
import '../bloc/notes_bloc.dart';
import '../helpers/notes_embed.dart';

import '../widgets/note_input_title_widget.dart';
import '../../../../ui/widgets/popup_options_widget.dart';

class NoteView extends StatefulWidget {
  final String id;

  const NoteView({
    super.key,
    required this.id,
  });

  @override
  State<NoteView> createState() => _NoteViewState();
}

////////////////////////////////////////////////////////////////////////////////
class _NoteViewState extends State<NoteView> {
  NoteEntity note = NoteEntity.empty();

  late final StatusCrudEnum status;
  XFile? file;

  final TextEditingController titleController = TextEditingController();

  late final flutter_quill.QuillController flutterQuillcontroller;
  late final FocusNode focusNodeNote;

  bool loading = false;
  bool editing = false;
  bool mostrarOpcionesTexto = false;
  bool isDesktop = false;

  late final NotesBloc blocProvider;

  @override
  void initState() {
    super.initState();
    focusNodeNote = FocusNode();

    blocProvider = BlocProvider.of<NotesBloc>(context, listen: false);
    getData();
  }

  @override
  void dispose() {
    titleController.dispose();
    flutterQuillcontroller.dispose();
    focusNodeNote.dispose();

    super.dispose();
  }

  Future<void> getData() async {
    if (widget.id != 'new') {
      setState(() {
        loading = true;
      });

      note = await injector<NoteRepository>().getById(
        int.parse(widget.id),
      );

      editing = note.appId != null;

      titleController.text = note.title;

      setState(() {
        loading = false;
      });
    }

    flutterQuillcontroller = note.appId == null
        ? flutter_quill.QuillController.basic()
        : flutter_quill.QuillController(
            document: flutter_quill.Document.fromJson(
              jsonDecode(note.body),
            ),
            selection: const TextSelection.collapsed(offset: 0),
          );
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
                        embedImage(
                          file!.path.toString(),
                          flutterQuillcontroller,
                        );
                      }
                    }
                    if (mounted) {
                      Navigator.of(context).maybePop();
                    }
                  },
                  child: const Column(
                    children: [
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
                      embedImage(file!.path.toString(), flutterQuillcontroller);
                    }
                    if (mounted) {
                      Navigator.of(context).maybePop();
                    }
                  },
                  child: const Column(
                    children: [
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

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    isDesktop = MediaQuery.of(context).size.width >= kMobileBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
            onPressed: () {
              note = note.copyWith(
                  title: titleController.text.trim(),
                  body: jsonEncode(
                    flutterQuillcontroller.document.toDelta().toJson(),
                  ),
                  createdAt: editing ? note.createdAt : getDateTimeUTC());

              if (editing) {
                blocProvider.add(NoteUpdatedEvent(note));
              } else {
                blocProvider.add(NoteCreatedEvent(note));
              }
            },
          ),
          IconButton(
            onPressed: () {
              addImage(context);
            },
            icon: const Icon(Icons.add_photo_alternate_outlined),
          ),
          if (!loading)
            PopupOptionsWidget(
              editing: editing,
              color: note.color,
              isFavorite: note.favorite,
              type: TypeLabels.notes,
              labels: blocProvider.state.labels,
              labelSelected: note.label,
              colorMessage: 'Color de la nota',
              canSelectImage: true,
              deleteMessageOption: 'Eliminar nota',
              onColorNoteChanged: (colorSelected) {
                setState(() {
                  note = note.copyWith(color: colorSelected);
                });
              },
              onFavoriteChanged: (isFavorite) {
                note = note.copyWith(favorite: isFavorite);
              },
              onOptionImagePressed: () {
                addImage(context);
              },
              onOptionDeletePressed: () {
                // TODO:
              },
              onLabelSelected: (value) {
                setState(() {
                  note = note.copyWith(label: value);
                });
              },
              onLabelCreatedAndSelected: (value) {
                blocProvider.add(AddLabelEvent(value));
                setState(() {
                  note = note.copyWith(label: value);
                });
              },
            ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (note.appId == null && widget.id != 'new') {
            return const Center(
              child: Text('nota no encontrada'),
            );
          }

          return Column(
            children: [
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
                    focusNode: focusNodeNote,
                    scrollController: ScrollController(),
                    configurations: flutter_quill.QuillEditorConfigurations(
                      controller: flutterQuillcontroller,
                      onTapDown: (details, p1) {
                        setState(() {
                          mostrarOpcionesTexto = true;
                        });
                        return false;
                      },
                      embedBuilders: [
                        ...FlutterQuillEmbeds.defaultEditorBuilders(),
                        NotesEmbedBuilder(addImage: addImage),
                      ],
                      expands: false,
                      padding: const EdgeInsets.all(0),
                      autoFocus: false,
                      readOnly: false,
                      scrollable: true,
                      placeholder: 'Escribe tu nota aqui...',
                      scrollBottomInset: 20,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                  ),
                  /* child: flutter_quill.QuillEditor(
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
                  ), */
                ),
              ),
              Visibility(
                visible: isDesktop || (keyboardVisible && mostrarOpcionesTexto),
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
                    child: flutter_quill.QuillToolbar.simple(
                      configurations:
                          flutter_quill.QuillSimpleToolbarConfigurations(
                        controller: flutterQuillcontroller,
                        showAlignmentButtons: true,
                        showDividers: true,
                        showDirection: true,
                        showFontFamily: false,
                        showFontSize: false,
                        customButtons: [
                          flutter_quill.QuillToolbarCustomButtonOptions(
                            icon:
                                const Icon(Icons.add_photo_alternate_outlined),
                            onPressed: () {
                              addImage(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* child: flutter_quill.QuillToolbar.basic(
                      controller: flutterQuillcontroller,
                      locale: const Locale('es'),
                      showAlignmentButtons: true,
                      showDividers: true,
                      showDirection: true,
                      showFontFamily: false,
                      showFontSize: false,
                      customButtons: [
                        flutter_quill.QuillCustomButton(
                          icon: Icons.add_photo_alternate_outlined,
                          onTap: () {
                            addImage(context);
                          },
                        ),
                      ],
                    ), */
                ),
              ),
              // const NoteSaveButtonWidget(),
            ],
          );
        },
      ),
    );
  }
}

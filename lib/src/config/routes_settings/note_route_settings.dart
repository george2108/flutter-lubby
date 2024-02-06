import 'package:flutter/widgets.dart';

import '../routes/routes.dart';
import '../../features/notes/entities/note_entity.dart';

class NoteRouteSettings extends RouteSettings {
  final BuildContext notesContext;
  final NoteEntity? note;

  const NoteRouteSettings({
    required this.notesContext,
    this.note,
  }) : super(name: noteRoute);
}

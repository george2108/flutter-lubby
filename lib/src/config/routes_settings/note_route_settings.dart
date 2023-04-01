import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/domain/entities/note_entity.dart';

class NoteRouteSettings extends RouteSettings {
  final BuildContext notesContext;
  final NoteEntity? note;

  const NoteRouteSettings({
    required this.notesContext,
    this.note,
  }) : super(name: noteRoute);
}

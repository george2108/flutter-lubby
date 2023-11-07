import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

embedImage(
  String imageUrl,
  flutter_quill.QuillController flutterQuillcontroller,
) {
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
    bool inline,
    TextStyle textStyle,
  ) {
    final image = NotesBlockEmbed(node.value.data).imageUrl;

    return Image.file(
      File(image),
    );
  }

  @override
  WidgetSpan buildWidgetSpan(Widget widget) {
    return WidgetSpan(child: widget);
  }

  @override
  bool get expanded => false;

  @override
  String toPlainText(flutter_quill.Embed node) {
    throw UnimplementedError();
  }
}

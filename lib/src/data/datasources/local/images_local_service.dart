import 'package:image_picker/image_picker.dart';

class ImagesLocalService {
  // TODO: Mover los archivos a la carpeta de data y crear la carpeta de datasources
  Future<XFile?> getImageCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    return image;
  }

  Future<List<XFile?>> getImagesGallery() async {
    final images = await ImagePicker().pickMultiImage();

    return images;
  }
}

import 'package:image_picker/image_picker.dart';

class ImagesLocalService {
  Future<XFile?> getImage(ImageSource imageSource) async {
    final images = await ImagePicker().pickImage(
      source: imageSource,
    );

    return images;
  }
}

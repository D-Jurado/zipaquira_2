import 'package:image_picker/image_picker.dart';
import 'camera_gallery.dart';

class CameraGalleryImpl extends CameraGallery {
  final ImagePicker picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        );

    if (photo == null) return null;

    print('Tenemos una imagen ${photo.path}');

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear);

    if (photo == null) return null;

    print('Tenemos una imagen ${photo.path}');

    return photo.path;
  }
}

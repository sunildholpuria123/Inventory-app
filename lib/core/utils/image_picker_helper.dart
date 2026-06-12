import 'package:file_picker/file_picker.dart';

class ImagePickerHelper {
  static Future<String?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) {
      return null;
    }

    return result.files.single.path;
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class ProductImageService {
  /// PICK + COPY IMAGE
  static Future<String?> pickAndSaveImage() async {
    final result =
    await FilePicker.platform
        .pickFiles(
      type: FileType.image,
    );

    if (result == null) {
      return null;
    }

    final originalPath =
        result.files.single.path;

    if (originalPath == null) {
      return null;
    }

    final originalFile =
    File(originalPath);

    /// APP DIRECTORY
    final appDir =
    await getApplicationDocumentsDirectory();

    /// PRODUCT IMAGE FOLDER
    final imageFolder =
    Directory(
      p.join(
        appDir.path,
        'InventoryERP',
        'ProductImages',
      ),
    );

    /// CREATE FOLDER
    if (!await imageFolder.exists()) {
      await imageFolder.create(
        recursive: true,
      );
    }

    /// FILE EXTENSION
    final extension =
    p.extension(originalPath);

    /// UNIQUE FILE NAME
    final fileName =
        'product_${DateTime.now().millisecondsSinceEpoch}$extension';

    final savedPath =
    p.join(
      imageFolder.path,
      fileName,
    );

    /// COPY FILE
    final savedFile =
    await originalFile.copy(
      savedPath,
    );

    return savedFile.path;
  }

  /// DELETE IMAGE
  static Future<void> deleteImage(
      String? path,
      ) async {
    if (path == null) {
      return;
    }

    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class SelectedImage {
  const SelectedImage({
    required this.file,
    required this.bytes,
  });

  final XFile file;
  final Uint8List bytes;

  String get displayName => file.name;

  static Future<SelectedImage?> pick({
    ImageSource source = ImageSource.gallery,
  }) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 2048,
    );
    if (file == null) return null;

    final bytes = await file.readAsBytes();
    return SelectedImage(file: file, bytes: bytes);
  }
}

import 'dart:io';

import 'package:boilerplate/utils/validation_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'functions_utils.dart';

class PickImageUtils {
  //Upload Image
  static Future<void> uploadImage(ImageSource source,
      {required Function(File file)? onPickImage}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );

    if (pickedFile != null) {
      if (onPickImage != null) {
        onPickImage(File(pickedFile.path));
      }
    }
  }

//pickMultiImage
  static Future<void> pickMultipleImage(ImageSource source,
      {required Function(List<File> files)? onPickImage}) async {
    final pickedFile = await ImagePicker().pickMultiImage();

    if (!isNullEmptyOrFalse(pickedFile)) {
      if (onPickImage != null) {
        onPickImage(pickedFile.map((e) => File(e.path)).toList());
      }
    }
  }

  //Pick attachments
  static Future<void> pickAttachments(
      {List<String>? extensions,
      FileType? fileType,
      required Function(File file)? onPickFile}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType ?? FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      debugLogText(
          'File Size ===> ${getStorageSizeString(bytes: file.lengthSync())}');
      debugLogText('File Path ===> ${file.path}');

      if (onPickFile != null) {
        onPickFile(file);
      }
    } else {
      // User canceled the picker
      //NavigationUtils.getBack();
    }
  }

  static Future<void> pickMultipleAttachments(
      {List<String>? extensions,
      FileType? fileType,
      required Function(List<File> files)? onPickFile}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType ?? FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      List<File> files = result.files.map((e) => File(e.path!)).toList();

      // debugLogText(
      //     'File Size ===> ${getStorageSizeString(bytes: file.lengthSync())}');
      //  debugLogText('File Path ===> ${file.path}');

      if (onPickFile != null) {
        onPickFile(files);
      }
    } else {
      // User canceled the picker
      //NavigationUtils.getBack();
    }
  }

  //Upload video
  static Future<void> uploadVideo(ImageSource source,
      {required Function(File file)? onPickVideo}) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);

    if (pickedFile != null) {
      if (onPickVideo != null) {
        onPickVideo(File(pickedFile.path));
      }
    }
  }
}

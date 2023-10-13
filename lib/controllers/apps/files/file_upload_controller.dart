import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadController extends MainController {
  List<PlatformFile> files = [];
  XFile? pickedXFile;
  var xProfileImageFiles = <XFile>[].obs;
  var xImageFiles = <XFile>[].obs;
  File? pickedIMageFile;
  List<File>? pickedFiles = [];
  String uploadedImageUrl = '';
  var uploadedProfileImage = ProfileImage(filename: '').obs;
  var uploadedImages = <ProfileImage>[];
  var isImagesAdded = false.obs;
  var isProfileImageAdded = false.obs;
  var isSavingSuccess = false.obs;
  var pickedProfileFile = File('').obs;
  late File file;
  Future<void> pickFile() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result?.files[0] != null) {
      files.add(result!.files[0]);
    }
    isImagesAdded.value = true;
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    isImagesAdded.value = false;
    update();
  }

  void removeFiles() {
    files.clear();
    update();
  }

  pickOfferItemImagesFromLocalStorage() async {
    xImageFiles.clear();
    ImagePicker imagePicker = ImagePicker();
    List<XFile> xFiles = await imagePicker.pickMultiImage(
        maxWidth: 600, maxHeight: 600, imageQuality: 50);
    if (xFiles.isNotEmpty) {
      xImageFiles.addAll(xFiles);
      update();
      debugPrint('$xFiles');
      debugPrint('xFiles Not Null ${xFiles[0].path}');
      isImagesAdded.value = true;
      // await uploadFiles();
    }
    update();
  }

  @override
  String getTag() {
    return "file_upload_controller";
  }
}

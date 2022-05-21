// ignore_for_file: invalid_use_of_visible_for_testing_member, file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import "package:image_picker/image_picker.dart";

class ChooseImage {
  Future getImage(ImageSource imageSource) async {
    XFile? xfile = await ImagePicker.platform.getImage(source: imageSource);
    if (xfile != null) {
      return File(xfile.path);
    } else {
      return null;
    }
  }

  static Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  static Future<String> uploadFile(File _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(_image.path);
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((value) async {
      String? url = await value.ref.getDownloadURL();
      print(url);
    });

    return await storageReference.getDownloadURL();
  }
}

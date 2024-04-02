import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FirebaseApi {
  late UploadTask task;

  static UploadTask? uploadFile(String desti, File file) {
    try {
      print('check = ' + File(file.path).toString());
      final ref = FirebaseStorage.instance.ref(desti);
      return ref.putData(File(file.path).readAsBytesSync());
    } on FirebaseException catch (e) {
      log('file error = ' + e.toString());
      return null;
    }
  }

  Future<String> getUrl(String filePath) async {
    String geturl = '';
    // try {
    final destination = 'file/${filePath.toString()}';
    task = FirebaseApi.uploadFile(destination, File(filePath.toString()))!;
    if (task == null) return '';
    final snapshot = await task.whenComplete(() {});
    await snapshot.ref.getDownloadURL().then((value) {
      print('video urls = ' + value);
      geturl = value;
    });
    //  / } catch (e) {}

    return geturl;
  }

  static UploadTask? uploadPDF(String desti, Uint8List filebytes) {
    try {
      final ref = FirebaseStorage.instance.ref(desti);
      return ref.putData(filebytes);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

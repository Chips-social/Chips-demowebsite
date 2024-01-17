import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

class ChipController extends GetxController {

  final showPreview = false.obs;
  final showImagePreview = false.obs;
  List<Uint8List> imageBytesList = [];
  List <File> files = [];
  final TextEditingController captionController = TextEditingController();
 
  setPreview(bool value) {
    showPreview.value = value;
  }


  removeImage(int index) {
    showImagePreview.value = false;
    files.removeAt(index);
    //imageBytesList.removeAt(index);
    if (imageBytesList.isNotEmpty) {
      showImagePreview.value = true;
    }
  }

}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  Future<String?> saveFileToPhoneMemory(
      String fileName, List<int> fileBytes) async {
    try {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      String filePath = "${appDocumentsDirectory.path}/$fileName";

      File file = File(filePath);
      await file.writeAsBytes(fileBytes);

      return filePath;
    } catch (e) {
      debugPrint("Dosya kaydetme hatası: $e");
      return null;
    }
  }
}

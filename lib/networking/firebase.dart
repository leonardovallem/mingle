import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future<String> uploadImage(XFile imageFile) async {
  String fileName = basename(imageFile.path);

  TaskSnapshot uploadTask = await FirebaseStorage.instance.ref(imageFile.name).putFile(File(imageFile.path));
  return await uploadTask.ref.getDownloadURL();
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  Uint8List? _image;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_image != null)
            CircleAvatar(
              minRadius: 160,
              backgroundImage: MemoryImage(_image!),
            ),
          if (_image == null)
            CircleAvatar(
                minRadius: 160,
                backgroundImage: NetworkImage(
                    "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg")),
          SizedBox(height: 20.he),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 30.he),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: width),
                            TextButton(
                                onPressed: () {
                                  _pickerImageFromGallery();
                                  Navigator.pop(context);
                                },
                                child: Text("Add galary")),
                            TextButton(
                                onPressed: () {
                                  _pickerImageFromCamera();
                                  Navigator.pop(context);
                                },
                                child: Text("Add camera")),
                          ],
                        ),
                      );
                    });
              },
              child: Text("Add image")),
        ],
      ),
    );
  }

  Future<void> _pickerImageFromGallery() async {
    final selectImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectImage != null) {
      imageFile = File(selectImage.path);
      _image = File(selectImage.path).readAsBytesSync();
      setState(() {});
    }
  }

  Future<void> _pickerImageFromCamera() async {
    final selectImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectImage != null) {
      imageFile = File(selectImage.path);
      _image = File(selectImage.path).readAsBytesSync();
      setState(() {});
    }
  }
}

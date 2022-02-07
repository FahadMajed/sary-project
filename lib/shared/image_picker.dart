import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImagePicker extends StatefulWidget {
  const ItemImagePicker({Key? key, required this.imagePickFn})
      : super(key: key);

  final void Function(File pickedImage) imagePickFn;

  @override
  _ItemImagePickerState createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  File _pickedImage = File("images/bar.png");

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 126,
    );
    setState(() => _pickedImage = File(pickedImageFile!.path));

    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: FileImage(_pickedImage),
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(
              Icons.image,
              color: Colors.black,
            ),
            label: const Text(
              'Pick Image',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

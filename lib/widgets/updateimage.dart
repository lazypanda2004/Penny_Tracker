import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class userimageupdate extends StatefulWidget {
  userimageupdate({
    super.key,
    required this.onPickImage,
    required this.intial,
  });
  final void Function(File pickedimage) onPickImage;
  FileImage intial;
  @override
  State<userimageupdate> createState() {
    return _userimagepickerstate();
  }
}

class _userimagepickerstate extends State<userimageupdate> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          child:
              _pickedImageFile == null ? Icon(Icons.camera_alt_outlined) : null,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : widget.intial,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}

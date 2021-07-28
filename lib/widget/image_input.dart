import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function selectedImage;
  ImageInput({
    Key? key,
    required this.selectedImage,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  Future<void> _takeImage() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );

    if (imageFile == null) {
      return;
    }

    File tempdir = File(imageFile.path);
    final appdir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    tempdir = await tempdir.copy("${appdir.path}/$fileName");

    widget.selectedImage(tempdir);
    print(" File dir is : ${tempdir.path}");
    setState(() {
      _selectedImage = tempdir;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 2,
          )),
          child: _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _takeImage,
            icon: Icon(Icons.camera),
            label: Text("Take Picture"),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_map/provider/great_Place.dart';
import 'package:flutter_image_map/widget/image_input.dart';
import 'package:flutter_image_map/widget/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = "add-place";
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  File? _pickedImage;

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveData() {
    if (titleController.text.isEmpty && _pickedImage == null) {
      print(" No Data Found.....");

      return;
    }
    Provider.of<GreatPlace>(context, listen: false)
        .addToList(titleController.text, _pickedImage!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "title",
                      labelText: "Title",
                    ),
                    controller: titleController,
                  ),
                  SizedBox(height: 15),
                  ImageInput(selectedImage: _selectedImage),
                SizedBox(height: 15),
                LocationInput(),                
                ]),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
              elevation: 0.0,
            ),
            onPressed: _saveData,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
          ),
        ],
      ),
    );
  }
}

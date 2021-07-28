import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_map/helper/db_helper.dart';
import 'package:flutter_image_map/modal/place.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get list {
    return [..._item];
  }

  void addToList(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );

    _item.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id!,
      "title": newPlace.title!,
      "image": newPlace.image!.path,
    });
  }

  Future<void> ftechAndSetData() async {
    final dataList = await DBHelper.getData("user_places");
    _item = dataList
        .map((item) => Place(
              id: item["id"],
              title: item["title"],
              location: null,
              image: File(item["image"]),
            ))
        .toList();
    notifyListeners();
  }
}

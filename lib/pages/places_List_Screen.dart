import 'package:flutter/material.dart';
import 'package:flutter_image_map/provider/great_Place.dart';
import 'package:provider/provider.dart';
import '../pages/add_Place_Screen.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
future: Provider.of<GreatPlace>(context,listen:false).ftechAndSetData(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlace>(
                    child: Center(
                        child: const Text(
                            "No item Added yet!\n Please add the Places ")),
                    builder: (context, greatPlace, ch) =>
                        greatPlace.list.length <= 0
                            ? ch!
                            : ListView.builder(
                                itemCount: greatPlace.list.length,
                                itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlace.list[i].image!),
                                  ),
                                  title: Text(greatPlace.list[i].title!),
                                  onTap: () {
                                    //!get detail Data .......
                                  },
                                ),
                              ),
                  ),
      ),
    );
  }
}

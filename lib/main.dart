import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/add_Place_Screen.dart';
import 'pages/places_List_Screen.dart';
import 'provider/great_Place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlace(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.deepPurple[600],
          accentColor: Colors.amber,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_flutter_app/exercise_list_screen.dart';

void main() {
  runApp(const MyGymApp());
}

class MyGymApp extends StatelessWidget {
  const MyGymApp({super.key}); // the super.key ensures that any key passed to MyGymApp is forwarded to the StatelessWidget.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( // I wrote the text style/colors in the other file since i find it more readable
        brightness: Brightness.light,
        textTheme: TextTheme(
          // In the other file i also added some shadow to the title
          titleLarge: TextStyle(fontSize: 16.6, fontWeight: FontWeight.bold, color: Colors.white),

        )

      ),
      debugShowCheckedModeBanner: false, // I take out the debug banner
      title: 'Gym App', // title
      home: ExerciseListScreen(), // home page is ExerciseListScreen
    );
  }
}


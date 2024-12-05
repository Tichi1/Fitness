import 'package:flutter/material.dart';
import 'package:my_flutter_app/exercise_detail_screen.dart';
import 'package:my_flutter_app/list_favorites.dart'; // Ensure this import exists for favorite operations
import 'package:like_button/like_button.dart'; // Package for animation

// Main page that displays the list of exercises

// Class for the list page
class ExerciseListScreen extends StatelessWidget {
  const ExerciseListScreen({super.key});

  @override

  // Set the title and the colors of the page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LEARN ABOUT YOUR FAVORITE EXERCISES!',
          style: TextStyle(
            shadows: [
              Shadow(
                offset: const Offset(2,2),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
        ),
        centerTitle: true, // We center the title
        backgroundColor: Colors.grey[350], // Background of the title
      ),


      body: Stack( // widget that allows multiple children to be layered on top of each other.
        children: [
          // This is for the background image
          Container(
            // Set adjustments of the image to cover the full screen size
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover, // Ensures the image covers the entire area
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // Adjust overlay opacity for better readability
                  BlendMode.darken, // Darkens the background for better contrast with text
                ),
              ),
            ),
          ),

          // Padding for content that sits on top of the background image
          Padding(
            padding: const EdgeInsets.all(20), // Space of the cards with the edges of the page

            child: Column(
              children: [
                const SizedBox(height: 20), // the space below the title and the cards
                Expanded(// widget that expands a child of a Column so that the child fills the available space
                  child: ListView(
                    children: [
                      ExerciseCard('Push-Ups', 'lib/icons/push-ups.png'), // Name exercise and icons.
                      ExerciseCard('Squats', 'lib/icons/squats.png'),
                      ExerciseCard('Lunges', 'lib/icons/lunges.png'),
                      ExerciseCard('Sit-Ups', 'lib/icons/sit-up.png'),
                      ExerciseCard('Bench Press', 'lib/icons/building.png'),
                      ExerciseCard('Pull-Ups', 'lib/icons/man.png'),
                      ExerciseCard('Deadlifts', 'lib/icons/training.png'),
                      ExerciseCard('Burpees', 'lib/icons/burpees.png'),
                      ExerciseCard('Plank', 'lib/icons/plank.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Represents each exercise with its parameters
// Stateful because the favorite status change
class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final iconPath;

  // Initialize the name and the icon
  const ExerciseCard(this.exerciseName, this.iconPath, {super.key});
  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

// Variable to store whether the exercise is currently marked as favorite
class _ExerciseCardState extends State<ExerciseCard> {
  // Variable that will hold the future variable of whether the exercise is marked as favorite or not
  late Future<bool> isFavoritedFuture;

  @override
  void initState() { // Called when the state object is first created
    super.initState();
    // Initialize the isFavoritedFuture to look the favorite status when the widget is created.
    // Use FavoriteExercises class
    isFavoritedFuture = FavoriteExercises().isFavorite(widget.exerciseName);
  }

  // Function to toggle the favorite status
  Future<void> _toggleFavorite() async {
    // Get the current favorite status
    bool isFavorited = await FavoriteExercises().isFavorite(widget.exerciseName);

    // Toggle the status depending on the current state
    if (isFavorited) {
      // Remove it if is favorite
      await FavoriteExercises().removeFavorite(widget.exerciseName);
    } else {
      // Add it if is not in favorite
      await FavoriteExercises().addFavorite(widget.exerciseName);
    }


  }

  @override
  Widget build(BuildContext context) { // its call whenever the widget state changes
    return Card( // Card widget
      // We asjust the settings for the card
      color: Colors.grey[350],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8), // Margin between cards

      child: ListTile( // Each card represents a list item. With icon and title
       // Settings for the icon
        leading: Container(
          width: 30, // Width for the icon container
          height: 30, // Height for the icon container
          decoration: BoxDecoration(
            shape: BoxShape.rectangle, // Make the icon shape a rectangle
            image: DecorationImage(
              image: AssetImage(widget.iconPath), // Load the custom icon directly
              // Ensure the icon fits the container nicely
            ),
          ),
        ),
        // The name of the exercise
        title: Text(
          widget.exerciseName,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        // The heart button appears at the right side of the card.

        trailing: SizedBox( // Trailing to display an item in the right hand
          width: 40,
          // Build the heart button based on the favorite status (using isFavoritedFuture)
          child: FutureBuilder<bool>(
            future: isFavoritedFuture, // Check if it's a favorite
            // Snapshot is the data we receive in the future
            builder: (context, snapshot) { // Take the current state of the future

              // Get the favorite status from the future
              bool isFavorited = snapshot.data!; // snapshot.data is true/false. non nullable
              //Widget that displays a heart button
              return LikeButton( // Display the heart icon with animation
                isLiked: isFavorited, // Initial state of the heart
                onTap: (isLiked) async { // When we triggered the Like button
                  await _toggleFavorite(); // Toggle favorite status
                  return !isLiked; // Return the updated status inverted
                },
                size: 30, // Size of the heart icon
                animationDuration: Duration(
                    milliseconds:2000),
                bubblesColor: BubblesColor( // Color of bubbles
                  dotPrimaryColor: Colors.red,
                  dotSecondaryColor: Colors.redAccent,
                ),
              );
            },
          ),
        ),
        // Navigate to detail screen when the card is tapped
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExerciseDetailScreen(exerciseName: widget.exerciseName),
            ),
          );
        },
      ),
    );
  }
}

/*
CARD:
https://api.flutter.dev/flutter/material/Card-class.html
https://www.youtube.com/watch?v=8PAfz0ln4rE
https://www.youtube.com/watch?v=E3SQOqUq8Mg

Icon:
https://www.youtube.com/watch?v=H46oNd2mjoU&t=184s
https://api.flutter.dev/flutter/widgets/IconData-class.html

Expanded:
https://api.flutter.dev/flutter/widgets/Expanded-class.html

Heart button:
https://youtu.be/c652qflFdF0?si=v5gGI0hOmk6yOOOm
Chat gpt. Helped me to fix some errors along the creation of the code for the heart

Listile:
https://www.youtube.com/watch?v=l8dj0yPBvgQ

Future Builder:
https://www.youtube.com/watch?v=zEdw_1B7JHY
https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html?gad_source=1&gclid=CjwKCAiA3ZC6BhBaEiwAeqfvyt_oxia9Xgz6B8LmrQU39s7kRZVEWNKpcMP_n_kUvh04hWdYnedtkxoCqvwQAvD_BwE&gclsrc=aw.ds

snapshot:
https://stackoverflow.com/questions/67482012/what-exactly-means-the-snapshot-in-a-futurebuilder-in-flutter

Trailing:
https://api.flutter.dev/flutter/material/ListTile/trailing.html

Heart animation:
https://www.youtube.com/watch?v=crGoUaTLclw
https://pub.dev/packages/custom_like_button


Images:
https://www.youtube.com/watch?v=Hxh6nNHSUjo&t=211s

Chat gpt: To fix some specific mistakes while setting the like button:

Shadow:
https://stackoverflow.com/questions/52227846/how-can-i-add-shadow-to-the-widget-in-flutter
*/
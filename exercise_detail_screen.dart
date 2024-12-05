import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Import youtube_player_flutter

// Stateful since we have some mutable(the video)
class ExerciseDetailScreen extends StatefulWidget {
  final String exerciseName;

  const ExerciseDetailScreen({super.key, required this.exerciseName});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

// State class that holds the mutable state for the class above
class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  // We define the controller of the video
  late YoutubePlayerController _controller;// late because it will be initialize late below

  @override
  void initState() { // Call when the widget is created
    super.initState();
    _controller = YoutubePlayerController( // we initialize the controller
      initialVideoId: getExerciseVideoUrl(widget.exerciseName), // get the id of the video
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false), // we specify option for the video
    );
  }

  // Function to return the info of each exercise
  String getExerciseInfo(String exerciseName) {
    switch (exerciseName) { // with switch we evaluate each exercsie and its info
      case 'Push-Ups':
        return 'Push-up exercise is a close chain kinetic exercise which improves joint proprioception, joint stability, and muscle co-activation around the shoulder joint. Push-ups activate a large number of muscles, increasing the heart rate and respiratory rate. They are also effective for weight loss and functional capacity assessment.';
      case 'Squats':
        return "Squats are a fundamental exercise that targets multiple muscle groups, primarily the quadriceps, hamstrings, glutes, and core, making them essential for building lower body strength and improving functional fitness. Squats help increase muscle mass, enhance mobility, and improve posture, stability, and balance, which can translate into better performance in daily activities and sports. To perform a proper squat, stand with your feet shoulder-width apart and your toes slightly pointing outward. Keep your chest up, engage your core, and lower your hips by bending your knees while keeping your weight on your heels. Make sure your knees track over your toes and don't extend past them. Lower yourself until your thighs are parallel to the ground or as deep as your mobility allows, then push through your heels to return to a standing position. Maintaining good form is crucial to avoid injury and ensure maximum benefits from the exercise.";
      case 'Lunges':
        return "Lunges are a dynamic lower-body exercise that targets the quads, glutes, and hamstrings, improving leg strength, balance, and coordination. Lunges also help enhance core stability and flexibility. To perform a proper lunge, stand with your feet hip-width apart. Step forward with one leg and lower your body until both knees are at 90-degree angles. The back knee should hover just above the ground, and the front knee should not extend past your toes. Push off the front foot to return to the starting position, then repeat with the other leg.";
      case 'Sit-Ups':
        return "Sit-ups are a classic core exercise primarily targeting the abdominal muscles, especially the rectus abdominis. They help build strength in the core, improve posture, and stabilize the spine. To do a sit-up, lie on your back with your knees bent and feet flat on the floor, hip-width apart. Cross your arms over your chest or place them behind your head. Engage your core and lift your upper body toward your thighs, keeping your back straight. Lower your torso back to the ground with control and repeat the movement.";
      case 'Bench Press':
        return "Bench Press is a compound upper-body exercise that primarily targets the chest, shoulders, and triceps. It's commonly used for building upper body strength and muscle mass. To perform a bench press, lie on a flat bench with your feet planted firmly on the ground. Grip the barbell with your hands slightly wider than shoulder-width apart. Lower the barbell slowly toward your chest, keeping your elbows at a 45-degree angle. Push the barbell back up to the starting position, fully extending your arms, while maintaining control throughout the movement.";
      case 'Pull-Ups':
        return "Pull-ups are a challenging upper-body exercise that targets the back, shoulders, and biceps. They help improve upper-body strength, posture, and grip strength. To perform a pull-up, grasp a pull-up bar with your hands slightly wider than shoulder-width apart, palms facing away from you. Hang with your arms fully extended and engage your core. Pull your body upward by bending your elbows until your chin is above the bar, then lower yourself back down with control. If pull-ups are too difficult at first, assisted pull-ups or negative pull-ups can help build strength.";
      case 'Deadlifts':
        return "Deadlifts are a compound movement that works multiple muscle groups, including the back, legs, and core, making them essential for building overall strength and power. To perform a deadlift, stand with your feet hip-width apart and a barbell in front of your shins. Bend at the hips and knees to grip the barbell with your hands just outside your knees. Keeping your back straight, lift the bar by extending your hips and knees simultaneously. Once standing tall, lower the bar back to the ground with control by reversing the movement. Proper form is essential to avoid strain on the lower back.";
      case 'Burpees':
        return "Burpees are a dynamic full-body exercise that combines a squat, jump, and push-up to target the legs, chest, arms, and core. This challenging movement not only builds strength but also improves cardiovascular endurance and coordination. To perform a burpee, start in a standing position, drop into a squat, place your hands on the ground, and kick your feet back into a push-up position. After performing a push-up, jump your feet forward to return to the squat position and then explode upwards into a jump. Repeat for a high-intensity workout.";
      case 'Plank':
        return 'The plank is a static exercise that primarily targets the core while also engaging the shoulders and glutes. It is excellent for enhancing core stability, improving posture, and building endurance in the muscles that support the spine. To perform a plank, position yourself as if doing a push-up but rest on your forearms instead of your hands. Keep your body straight from head to heels, engaging your core muscles to maintain the position for as long as possible.';
      default:
        return 'Information not available.'; // In case there is no exercise
    }
  }

  // Function to return Youtube video URL
  String getExerciseVideoUrl(String exerciseName) {
    final exerciseVideos = {
      'Push-Ups': 'JyCG_5l3XLk',
      'Squats': 'gcNh17Ckjgg',
      'Lunges': 'wrwwXE_x-pQ',
      'Sit-Ups': 'UMaZGY6CbC4',
      'Bench Press': 'rxD321l2svE',
      'Pull-Ups': 'itaC8CXWP6A',
      'Deadlifts': 'XxWcirHIwVo',
      'Burpees': 'mG0iaoLM2vc',
      'Plank': 'ASdvN_XEl_c',
    };
    return exerciseVideos[exerciseName] ?? ''; // If there is no url
  }

  @override
  Widget build(BuildContext context) { // its call whenever the widget state changes
    String exerciseInfo = getExerciseInfo(widget.exerciseName);

    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView( // So we can scroll through the page
        child: Padding(
          padding: const EdgeInsets.all(16), // Add the padding for better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align elements to the start
            children: [
              // Display the exercise name (title of each exercise)
              Text(
                widget.exerciseName, // Name of the exercise as a title
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 15), // Space bw title and info

              // Display the exercise information in a card
              Card(
                elevation:20, // Shadow of the t
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Border of the card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16), // Space of the text with the card
                  child: Text(
                    'Information: \n$exerciseInfo',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space of the video with the video

              // Create the box of the yt video and call YtPlayer
              SizedBox(
                width: double.maxFinite, // As long as the container
                height: 300, // Set a fixed height for the video
                // Pass a the earlier created controller instance to the Yt player widget
                child: YoutubePlayer(controller: _controller), //  //
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Youtube Player:
https://pub.dev/packages/youtube_player_flutter
https://www.youtube.com/watch?v=SkoUu1vhgbg
https://www.youtube.com/watch?v=YMx8Bbev6T4&t=22s

switch statement:
https://dart.dev/language/branches

SizedBox:
https://api.flutter.dev/flutter/widgets/SizedBox-class.html

Padding:
https://api.flutter.dev/flutter/widgets/Padding-class.html

chat gpt: helped me with the use of switch statement.

*/



import 'package:shared_preferences/shared_preferences.dart'; // import the shared preferences

// Class to manage the favorites list of users
class FavoriteExercises{
  // a static String used as a key to access the saved list of favorites
  static const String favoriteKey = 'Favourites Exercises';

  // Here we SAVE the list of favourites exercises
  // Create the list
  Future<void> saveFavorites(List<String> favorites) async{
    // We access the device’s SharedPreferences storage.
    final prefs = await SharedPreferences.getInstance();
    // We saves the favorites list in SharedPreferences as favouritesKey
    // With setStringList we save a list of strings
    await prefs.setStringList(favoriteKey, favorites);
  }

  // Class to get the exercises
  Future<List<String>> loadExercises() async{
    final prefs = await SharedPreferences.getInstance();
    // We retrieve the list of favorites exercise under the key favoriteKey.
    // Return empty if there are no favorites exercises
    return prefs.getStringList(favoriteKey)?? [] ;
  }

  // Add a favorite exercise
  Future<void> addFavorite(String exercise) async{
    // Get the current list
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = await loadExercises();
    // If the exercise is not in the list, add it
    if (!favorites.contains(exercise)){
      favorites.add(exercise);
      // We save it
      await prefs.setStringList(favoriteKey, favorites);
    }
  }

  // Remove an exercise form the favorite list
  Future<void> removeFavorite(String exercise) async{
    // Get the current list
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = await loadExercises();
    // If the exercise is in the list, remove it
    if (favorites.contains(exercise)){
      favorites.remove(exercise);
      // We save it
      await prefs.setStringList(favoriteKey, favorites);
    }
  }
  // Make a class to see if a exercise is mark as favorite
  Future<bool> isFavorite(String exercise) async{
    List<String> favorites = await loadExercises();
    return favorites.contains(exercise);
  }
}




/*
SOURCES:
SharePreferences package: https://www.youtube.com/watch?v=uyz0HrGUamc

SharedPreferences:
https://medium.com/@faikirkham/shared-preferences-in-flutter-a-simple-guide-to-storing-local-data-7b5b2506dee9#:~:text=Once%20the%20package%20is%20added,()%20%2C%20or%20setStringList()%20methods.
https://www.youtube.com/watch?v=Ccd5fIrCDSY
chat gpt: Helped me to fix errors with the use of prefs and the add/remove function
*/

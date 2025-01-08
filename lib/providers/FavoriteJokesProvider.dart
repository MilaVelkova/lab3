import 'package:flutter/foundation.dart';

class FavoriteJokesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favoriteJokes = [];

  List<Map<String, dynamic>> get favoriteJokes => _favoriteJokes;

  void addToFavorites(Map<String, dynamic> joke) {
    _favoriteJokes.add(joke);
    notifyListeners();
  }

  void removeFromFavorites(Map<String, dynamic> joke) {
    _favoriteJokes.remove(joke);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../services/api_services.dart';

class JokeListScreen extends StatefulWidget {
  final String type;
  final Function(Map<String, dynamic>) addToFavorites;

  JokeListScreen({required this.type, required this.addToFavorites});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  Map<int, bool> favoritesMap = {};
  List<dynamic>? jokesList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    try {
      final jokes = await ApiService.getJokesByType(widget.type);
      setState(() {
        jokesList = jokes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading jokes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          '${widget.type} Jokes',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color.fromRGBO(229, 204, 255, 1),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : jokesList == null || jokesList!.isEmpty
          ? Center(child: Text('No jokes found!'))
          : ListView.builder(
        itemCount: jokesList!.length,
        itemBuilder: (context, index) {
          final joke = jokesList![index];
          final isFavorite = favoritesMap[index] ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  joke['setup'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  joke['punchline'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (!isFavorite) {
                      widget.addToFavorites(joke);
                      setState(() {
                        favoritesMap[index] = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to favorites'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Already added to favorites'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

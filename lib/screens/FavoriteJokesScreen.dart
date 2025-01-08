import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/FavoriteJokesProvider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteJokes = context.watch<FavoriteJokesProvider>().favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Jokes',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      backgroundColor: Color.fromRGBO(229, 204, 255, 1),
      body: favoriteJokes.isEmpty
          ? Center(
        child: Text(
          'No favorite jokes yet!',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      joke['setup'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      joke['punchline'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<FavoriteJokesProvider>().removeFromFavorites(joke);
                          },
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

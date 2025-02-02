// home/fav.dart

import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteQuotes;
  final Function(String) removeFromFavorites;

  const FavoritesPage({
    super.key,
    required this.favoriteQuotes,
    required this.removeFromFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: favoriteQuotes.isEmpty
          ? const Center(
              child: Text(
                'No favorite quotes yet!',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                final quote = favoriteQuotes[index];
                return ListTile(
                  title: Text(quote),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeFromFavorites(quote),
                  ),
                );
              },
            ),
    );
  }
}

// features/home/quote_home.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quote_task2/core/services/local_storage/local_storage.dart';
import 'package:quote_task2/features/home/fav.dart';
import 'package:quote_task2/features/quote_home/data/quote%20class.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteHomePage extends StatefulWidget {
  const QuoteHomePage({super.key});

  @override
  State<QuoteHomePage> createState() => _QuoteHomePageState();
}

class _QuoteHomePageState extends State<QuoteHomePage> {
  String? currentQuote;
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    loadQuote();
    loadFavorites();
  }

  void loadQuote() {
    final random = Random();
    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];
    });
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> saveToFavorites(String quote) async {
    final prefs = await SharedPreferences.getInstance();
    if (!favoriteQuotes.contains(quote)) {
      setState(() {
        favoriteQuotes.add(quote);
      });
      await prefs.setStringList('favorites', favoriteQuotes);
    }
  }

  Future<void> removeFromFavorites(String quote) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes.remove(quote);
    });
    await prefs.setStringList('favorites', favoriteQuotes);
  }

  void shareQuote(String quote) {
    Share.share(quote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote of the Day'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favoriteQuotes: favoriteQuotes,
                    removeFromFavorites: removeFromFavorites,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentQuote != null)
                Text(
                  currentQuote!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => shareQuote(currentQuote!),
                child: const Text('Share Quote'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => saveToFavorites(currentQuote!),
                child: const Text('Save to Favorites'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadQuote();
         
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

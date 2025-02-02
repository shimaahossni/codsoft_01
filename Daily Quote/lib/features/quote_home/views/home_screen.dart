// features/quote_home/views/home_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote_task2/core/services/local_storage/local_storage.dart';
import 'package:quote_task2/features/quote_home/data/quote%20class.dart';
import 'package:quote_task2/features/quote_home/widget/button_custom.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentQuote;
  List<String> favoriteQuotes = [];

  // Load quotes
  void loadQuote() {
    if (quotes.isNotEmpty) {
      final random = Random();
      setState(() {
        currentQuote = quotes[random.nextInt(quotes.length)];
      });
    } else {
      setState(() {
        currentQuote = "No quotes available.";
      });
    }
  }

  // Share quote
  void shareQuote(String quote) {
    Share.share(quote);
  }

  // Display favorite quotes in a Bottom Sheet for 5 seconds
  // Display favorite quotes in a Bottom Sheet for 5 seconds
  void _showFavoriteQuotes() {
    if (favoriteQuotes.isNotEmpty) {
      final bottomSheetController = showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop(); // Close the bottom sheet when tapped outside
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favorites:',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),
                  ...favoriteQuotes.take(5).map((quote) => Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF9162FF),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 5.0,
                                offset: Offset(2, 2),
                              )
                            ]),
                        child: Text(
                          quote,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      );

      // Automatically close the bottom sheet after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop(); // Close the bottom sheet
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadQuote();
    // Retrieve cached favorite quotes and cast to List<String>
    favoriteQuotes = (AppLocalStorage.getCachedData(
          key: AppLocalStorage.favorites,
        ) as List<Object?>?)
            ?.cast<String>() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3B3B98), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Header
              Text(
                'Daily Quote',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaQuery.width * .12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(mediaQuery.height * .05),
              // Circular Quote Container
              Container(
                width: mediaQuery.width * .8,
                height: mediaQuery.width * .8,
                decoration: BoxDecoration(
                  color: const Color(0xFF9162FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9162FF).withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: mediaQuery.width * .75,
                  height: mediaQuery.width * .75,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Text(
                          currentQuote != null
                              ? currentQuote!
                              : "No quotes today.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mediaQuery.width * .06,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(mediaQuery.height * .05),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentQuote != null) {
                        shareQuote(currentQuote!);
                      }
                    },
                    icon: Icon(
                      Icons.share,
                      color: const Color(0xFF9162FF),
                      size: mediaQuery.width * .1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentQuote != null) {
                        setState(() {
                          favoriteQuotes.add(currentQuote!);
                          // Cache the updated favorite list
                          AppLocalStorage.cacheData(
                            key: AppLocalStorage.favorites,
                            value: favoriteQuotes,
                          );
                        });
                      }
                    },
                    icon: Icon(
                      // Change icon based on whether the quote is in favorites
                      favoriteQuotes.contains(currentQuote)
                          ? Icons.favorite // Filled heart if it's a favorite
                          : Icons
                              .favorite_border, // Empty heart if it's not a favorite
                      color: favoriteQuotes.contains(currentQuote)
                          ? Colors.red // Red if it's a favorite
                          : Colors.white, // White if it's not a favorite
                      size: mediaQuery.width * .1,
                    ),
                  )
                ],
              ),
              const Spacer(),
              // Bottom navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCustom(
                        onPressed: () {
                          loadQuote();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: mediaQuery.width * .08,
                        ),
                      ),
                      ButtonCustom(
                        onPressed: _showFavoriteQuotes,
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: mediaQuery.width * .08,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

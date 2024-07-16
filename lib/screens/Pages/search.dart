import 'package:flutter/material.dart';

// Classe pour gérer la recherche de posts
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}

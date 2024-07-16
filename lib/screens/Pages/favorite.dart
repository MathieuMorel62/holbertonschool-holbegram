import 'package:flutter/material.dart';

// Classe pour gérer les favoris
class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Favorite'),
      ),
      body: const Center(
        child: Text('Favorite Page'),
      ),
    );
  }
}

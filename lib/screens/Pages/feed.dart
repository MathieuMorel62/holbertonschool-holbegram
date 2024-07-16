import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

// Classe pour gérer le feed
class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 28),

          // Barre de navigation
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [

                // Titre de l'application
                const Text(
                  'Holbegram',
                  style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 1),

                // Logo de l'application
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
              ],
            ),
            actions: <Widget>[
              // Bouton d'ajout de post
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {},
              ),
              // Bouton de messages
              IconButton(
                icon: const Icon(Icons.message_outlined, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          // Liste des posts de l'utilisateur
          const Expanded(
            child: Posts(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';


// Classe pour ajouter une image
class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Image'),
      ),
      body: const Center(
        child: Text('Add Image Page'),
      ),
    );
  }
}

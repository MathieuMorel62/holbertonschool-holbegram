import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour uploader un post
  Future<String> uploadPost(String caption, String uid, String username, String profImage, Uint8List image) async {
    try {
      // Uploader l'image sur Firebase Storage
      String imageUrl = await StorageMethods().uploadImageToStorage(true, 'posts', image);

      // Créer un identifiant unique pour le post
      String postId = _firestore.collection('posts').doc().id;

      // Créer un post avec les détails fournis
      await _firestore.collection('posts').doc(postId).set({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'postUrl': imageUrl,
        'postId': postId,
        'datePublished': DateTime.now(),
        'likes': [],
      });

      return 'Ok';
    } catch (e) {
      return e.toString();
    }
  }

  // Méthode pour supprimer un post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      rethrow;
    }
  }
}

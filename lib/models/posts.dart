import 'package:cloud_firestore/cloud_firestore.dart';


// Classe pour gérer les données des posts
class Post {
  final String caption;
  final String uid;
  final String username;
  final List likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  // Constructeur pour initialiser les données du post
  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  // Convertir les données en objet
  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      caption: json['caption'],
      uid: json['uid'],
      username: json['username'],
      likes: List<String>.from(json['likes']),
      postId: json['postId'],
      datePublished: (json['datePublished'] as Timestamp).toDate(),
      postUrl: json['postUrl'],
      profImage: json['profImage'],
    );
  }

  // Convertir les données en JSON
  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'username': username,
      'likes': likes,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}

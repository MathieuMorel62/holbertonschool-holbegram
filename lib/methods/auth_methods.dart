import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/models/user.dart';
import 'dart:typed_data';


// Classe pour gérer les méthodes d'authentification
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour se connecter
  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }

    // Connexion de l'utilisateur
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  // Méthode pour s'inscrire
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }

    // Inscription de l'utilisateur
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Récupérer l'utilisateur actuel
      User? user = userCredential.user;

      // Enregistrer les données de l'utilisateur dans Firestore
      if (user != null) {
        Users newUser = Users(
          uid: user.uid,
          email: email,
          username: username,
          bio: '',
          photoUrl: '',
          followers: [],
          following: [],
          posts: [],
          saved: [],
          searchKey: username[0].toUpperCase(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
      }

      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  // Méthode pour obtenir les détails de l'utilisateur actuel
  Future<Users> getUserDetails() async {
    User? currentUser = _auth.currentUser;

    // Vérifier si l'utilisateur est connecté
    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    // Récupérer les données de l'utilisateur actuel depuis Firestore
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return Users.fromSnap(snap);
  }
}

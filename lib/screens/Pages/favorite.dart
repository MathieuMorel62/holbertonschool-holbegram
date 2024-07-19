import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Classe Favorite, affichant la page des favoris de l'utilisateur
class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Configuration de la barre de navigation
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Column(
          children: [
            const SizedBox(height: 28),

            // Barre de navigation de la page des favoris
            AppBar(
              backgroundColor: Colors.white,
              title: Container(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Billabong',
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              elevation: 0,
            ),
          ],
        ),
      ),

      body: StreamBuilder(
        // Récupération des données de la collection 'favorites' de l'utilisateur
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          // Gestion des erreurs
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Récupération des documents des favoris
          final favoriteDocs = snapshot.requireData.docs;

          // Affichage des favoris de l'utilisateur sous forme de liste
          return ListView.builder(
            itemCount: favoriteDocs.length,
            itemBuilder: (context, index) {
              var favoriteDoc = favoriteDocs[index];

              // Utilisation de FutureBuilder pour récupérer les détails des posts favoris
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(favoriteDoc['postId'])
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> postSnapshot) {

                  // Gestion des erreurs lors de la récupération des données
                  if (postSnapshot.hasError) {
                    return Center(child: Text('Error: ${postSnapshot.error}'));
                  }
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Vérification de l'existence des données
                  if (!postSnapshot.hasData || !postSnapshot.data!.exists) {
                    return Container();
                  }

                  // Récupération des données du post
                  var post = postSnapshot.data!;

                  // Affichage des posts favoris avec une image de couverture
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(post['postUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/screens/pages/methods/post_storage.dart';


// Widget Posts, affichant les posts de l'utilisateur récupérés depuis la base de données
class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      // Écoute des données de la collection 'posts' de la base de données
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

        // Gestion des erreurs
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Affichage d'un cercle de chargement si les données sont en cours de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Récupération des données de la collection 'posts'
        final data = snapshot.requireData;

        // Affichage des posts de l'utilisateur sous forme de liste
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            var post = data.docs[index];

            // S'assurer que 'likes' est un entier
            int likesCount = (post['likes'] is List) ? post['likes'].length : post['likes'] ?? 0;

            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [

                      // Affichage de l'image de profil de l'utilisateur
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(post['profImage']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Affichage du nom d'utilisateur de l'utilisateur
                      Text(post['username']),
                      const Spacer(),

                      // Affichage du bouton de plus pour les options de post (supprimer)
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () async {
                          bool? deleteConfirmed = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this post?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );

                          // Suppression du post si l'utilisateur confirme
                          if (deleteConfirmed == true) {
                            await PostStorage().deletePost(post['postId']);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Post Deleted')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Affichage de la légende du post
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['caption']),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),

                  // Affichage de l'image du post
                  Center(
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(post['postUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Affichage des boutons d'interaction pour le post
                  Row(
                    children: [
                      FavoriteIconButton(postId: post.id, likes: likesCount),
                      IconButton(
                        icon: const Icon(Icons.comment_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Affichage du nombre de likes pour le post
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$likesCount Liked',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Widget FavoriteIconButton, permettant à l'utilisateur de marquer un post comme favori
class FavoriteIconButton extends StatefulWidget {
  final String postId;
  final int likes;
  const FavoriteIconButton({required this.postId, required this.likes, super.key});

  @override
  FavoriteIconButtonState createState() => FavoriteIconButtonState();
}

class FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool isFavorited = false;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    likesCount = widget.likes;
    checkIfFavorited();
  }

  // Vérification si le post est déjà marqué comme favori
  void checkIfFavorited() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(widget.postId)
          .get();
      setState(() {
        isFavorited = doc.exists;
      });
    }
  }

  // Fonction pour marquer/démarquer un post comme favori
  void toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference favRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(widget.postId);

      DocumentReference postRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId);

      if (isFavorited) {
        await favRef.delete();
        await postRef.update({'likes': FieldValue.increment(-1)});
        setState(() {
          isFavorited = false;
          likesCount--;
        });
      } else {
        await favRef.set({'postId': widget.postId});
        await postRef.update({'likes': FieldValue.increment(1)});
        setState(() {
          isFavorited = true;
          likesCount++;
        });
      }
    }
  }

  // Affichage du bouton de favori
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_outline,
        color: isFavorited ? Colors.red : null,
      ),
      onPressed: toggleFavorite,
    );
  }
}

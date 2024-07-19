import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


// Définition de la classe Search
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  SearchState createState() => SearchState();
}

// Classe d'état assosciée au Stateful Widget Search
class SearchState extends State<Search> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),

              // Barre de recherche avec un champ de texte
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
          ),
        ),
      ),

      // Affichage des images en fonction de la recherche
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Récupération des données de la collection 'posts'
            final data = snapshot.requireData;

            // Filtrage des données en fonction de la recherche de l'utilisateur
            var filteredData = data.docs.where((doc) {
              return (doc['caption'] as String)
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  (doc['username'] as String)
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase());
            }).toList();

            // Affichage des images en fonction de la recherche
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var post = filteredData[index];
                return Image.network(
                  post['postUrl'],
                  fit: BoxFit.cover,
                );
              },
              staggeredTileBuilder: (index) {
                if (index % 3 == 0) {
                  return const StaggeredTile.count(4, 2);
                } else {
                  return const StaggeredTile.count(2, 2);
                }
              },
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          },
        ),
      ),
    );
  }
}

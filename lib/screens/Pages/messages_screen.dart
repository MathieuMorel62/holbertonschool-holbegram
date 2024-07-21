import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Classe principale de l'écran des messages
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  MessagesScreenState createState() => MessagesScreenState();
}

// État associé à la classe MessagesScreen
class MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      // Utilisation de StreamBuilder pour écouter les changements en temps réel dans Firestore
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // Affiche un message d'erreur si une erreur se produit
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Affiche un indicateur de chargement tant que les données sont en cours de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Récupère les messages depuis l'instantané de données
          final messages = snapshot.data!.docs;

          // Affiche un message si aucun message n'est disponible
          if (messages.isEmpty) {
            return const Center(
              child: Text(
                'No messages available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Affiche les messages dans une liste
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              return MessageTile(message: message);
            },
          );
        },
      ),
    );
  }
}

// Classe pour représenter une tuile de message individuelle
class MessageTile extends StatelessWidget {
  final QueryDocumentSnapshot message;
  const MessageTile({super.key, required this.message});

  // Méthode pour supprimer un message
  void deleteMessage(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(message.id)
        .delete();

    // Affiche une notification de confirmation après la suppression
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message deleted')),
    );
  }

  // Méthode pour répondre à un message
  void replyToMessage(BuildContext context, String senderId) async {
    TextEditingController replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reply to Message'),
        content: TextField(
          controller: replyController,
          decoration: const InputDecoration(hintText: 'Enter your reply'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              User? currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(senderId)
                    .collection('messages')
                    .add({
                  'senderId': currentUser.uid,
                  'content': replyController.text,
                  'timestamp': Timestamp.now(),
                  'read': false,
                });

                // Affiche une notification de confirmation après l'envoi de la réponse
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reply sent successfully')),
                );

                Navigator.of(context).pop();
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(message['senderId']).get(),
      builder: (context, snapshot) {
        // Affiche un nom et un statut de chargement par défaut tant que les données ne sont pas chargées
        if (!snapshot.hasData) {
          return const ListTile(
            title: Text('Anonymous'),
            subtitle: Text('Loading...'),
          );
        }

        var sender = snapshot.data!.data() as Map<String, dynamic>;
        var senderName = sender['username'];
        var senderPhotoUrl = sender['photoUrl'];

        // Met à jour l'état du message en "lu" si nécessaire
        if (message['read'] == false) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('messages')
              .doc(message.id)
              .update({'read': true});
        }

        // Affiche les détails du message dans une tuile
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(senderPhotoUrl),
          ),
          title: Text(senderName),
          subtitle: Text(message['content']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.reply, color: Colors.blue),
                onPressed: () => replyToMessage(context, message['senderId']),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteMessage(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

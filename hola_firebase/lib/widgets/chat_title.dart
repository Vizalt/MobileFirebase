import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
          stream: db.doc("/chats/nYCZS6VlFfIDeaessPi6").snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
          ) {
            // 1. Mirar si hi ha hagut errors
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            // 2. Si encara no tenim dades
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final docSnap = snapshot.data!; // Extreure dades del AsyncSnapshot
            return Text(docSnap['title']);
          },
        );
  }
}
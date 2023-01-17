import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/comics.dart';

class ComicSelectedScreen extends StatelessWidget {
  const ComicSelectedScreen({
    required this.comic,
    Key? key,
  }) : super(key: key);

  final Comic comic;
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.collection("/comics").add({
            'title': comic.title,
            'description': comic.description,
            'createdAt': Timestamp.now(),
            'imageURL': comic.thumbnailPath,
            'imageURLext': comic.thumbnailExt,
            'pageCount': comic.pageCount,
          });
        },
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
        child: const Icon(
          Icons.turned_in_not,
          color: Colors.white,
        ),
      ),
    );
  }
}

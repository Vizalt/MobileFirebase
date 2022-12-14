import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';

class ComicWidget extends StatelessWidget {
  const ComicWidget({
    Key? key,
    required this.comic,
  }) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return InkWell(
      splashColor: const Color.fromARGB(255, 197, 52, 41).withAlpha(30),
      onTap: (() {
        db.collection("/comics").add({
          'title': comic.title,
          'createdAt': Timestamp.now(),
        });
      }),
      child: Stack(
        children: [
          Center(
            child: Image.network(
              '${comic.thumbnailPath}/standard_large.${comic.thumbnailExt}', // URL de la imagen
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 300,
              height: 50,
              color: const Color.fromARGB(144, 37, 37, 37),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  comic.title,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

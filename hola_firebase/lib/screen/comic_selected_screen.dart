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
      body: Center(
        child: Column(
          children: [
            /*Container(
              color: Colors.amber,
              height: 40,
            ),*/
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.network(
                '${comic.thumbnailPath}/portrait_fantastic.${comic.thumbnailExt}', // URL de la imagen
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(comic.title,
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 12,
            ),
            Text(
              comic.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text("Format:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(comic.format),
                  ],
                ),
                Row(
                  children: [
                    const Text("Page Count:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(comic.pageCount.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
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

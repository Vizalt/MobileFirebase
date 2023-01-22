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
        backgroundColor: const Color.fromARGB(255, 128, 26, 19),
      ),
      body: Container(
        color: Color.fromARGB(255, 71, 27, 25),
        child: Center(
          child: Column(
            children: [
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
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(comic.title,
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  comic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 35,
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.download,
                          size: 30,
                        ),
                        Text(
                          'Download',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 143, 15, 15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 35,
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.play_arrow,
                          size: 30,
                        ),
                        Text(
                          'Read Online',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
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

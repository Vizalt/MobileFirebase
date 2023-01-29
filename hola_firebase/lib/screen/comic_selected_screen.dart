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
      backgroundColor: const Color.fromARGB(255, 71, 27, 25),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white10),
                child: Center(
                  child: Image.network(
                    '${comic.thumbnailPath}/portrait_fantastic.${comic.thumbnailExt}', // URL de la imagen
                  ),
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
                  InkWell(
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text(
                                "Not Available",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              content: Text(
                                  "This option is not available right now, try again later."),
                            );
                          });
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
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
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text(
                                "Not Available",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              content: Text(
                                  "This option is not available right now, try again later."),
                            );
                          });
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 143, 15, 15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
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
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
            'format': comic.format,
          });
        },
        backgroundColor: const Color.fromARGB(255, 122, 29, 22),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

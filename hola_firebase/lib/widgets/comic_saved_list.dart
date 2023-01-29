import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/comics.dart';
import '../screen/comic_selected_screen.dart';

class ComicSavedList extends StatelessWidget {
  const ComicSavedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    Comic comic = Comic(
        title: '',
        description: '',
        format: '',
        pageCount: 0,
        thumbnailPath: '',
        thumbnailExt: '');
    return StreamBuilder(
      stream: db
          .collection("/comics")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;
        return GridView.builder(
          itemCount: docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            final doc = docs[index];
            return InkWell(
              onTap: (() {
                comic.title = doc["title"] ?? "No title";
                comic.description = doc["description"] ?? "No decription";
                comic.format = doc["format"] ?? "No format";
                comic.pageCount = doc["pageCount"] ?? 0;
                comic.thumbnailPath = doc["imageURL"] ?? "No image";
                comic.thumbnailExt = doc["imageURLext"] ?? "No image";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComicSelectedScreen(
                      comic: comic,
                    ),
                  ),
                );
              }),
              onDoubleTap: () {
                String docID = doc.id;
                db.doc("/comics/$docID").delete();
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      '${doc["imageURL"]}/portrait_xlarge.${doc["imageURLext"]}', // URL de la imagen
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
                          doc["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
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

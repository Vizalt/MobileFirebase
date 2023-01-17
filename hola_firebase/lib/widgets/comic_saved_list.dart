import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComicList extends StatelessWidget {
  const ComicList({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
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
            crossAxisCount: 3, // Relación de aspecto de las celdas
          ),
          itemBuilder: (context, index) {
            final doc = docs[index];
            //final date = (doc['createdAt'] as Timestamp).toDate();
            return Stack(
              children: [
                Center(
                  child: Image.network(
                    '${doc["imageURL"]}/standard_large.${doc["imageURLext"]}', // URL de la imagen
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
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
            /*return ListTile(
              title: Text(doc['title']),
              subtitle: Text(
                "${date.toIso8601String()} ${doc.id}",
              ),
            );*/
          },
        );
      },
    );
  }
}

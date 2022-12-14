import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';
import 'package:hola_firebase/widgets/comic_widget.dart';


class ComicGridScreen extends StatefulWidget {
  const ComicGridScreen({Key? key}) : super(key: key);

  @override
  State<ComicGridScreen> createState() => _ComicGridScreenState();
}

class _ComicGridScreenState extends State<ComicGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comics List"),
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
      ),
      body: FutureBuilder(
        future: loadComicList(),
        builder: (context, AsyncSnapshot<List<Comic>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final comicList = snapshot.data!;
          return GridView.builder(
            itemCount: comicList.length,
            itemBuilder: (context, index) =>
                ComicWidget(comic: comicList![index]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Relación de aspecto de las celdas
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/saved-list');
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

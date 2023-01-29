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
        title: const Text(
          "Marvel Comics",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 128, 26, 19),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 71, 27, 25),
        child: FutureBuilder(
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
                  ComicWidget(comic: comicList[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/saved-list');
        },
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
        child: const Icon(
          Icons.turned_in_not_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

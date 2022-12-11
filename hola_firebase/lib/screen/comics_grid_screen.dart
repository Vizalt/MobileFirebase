import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';
import 'package:hola_firebase/widgets/comic_widget.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

class ComicGridScreen extends StatefulWidget {
  const ComicGridScreen({Key? key}) : super(key: key);

  @override
  State<ComicGridScreen> createState() => _ComicGridScreenState();
}

class _ComicGridScreenState extends State<ComicGridScreen> {
  List<Comic>? comicList;

  @override
  void initState() {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String concatenatedString = '$timeStamp$privateKey$publicKey';
    String hash = md5.convert(utf8.encode(concatenatedString)).toString();
    loadComicList(hash, timeStamp).then((loadedComicList) {
      setState(() {
        comicList = loadedComicList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (comicList == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Comics List(Loading...)"),
          backgroundColor: const Color.fromARGB(255, 197, 52, 41),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comics List"),
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
      ),
      body: GridView.builder(
        itemCount: comicList!.length,
        itemBuilder: (context, index) => ComicWidget(comic: comicList![index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Relación de aspecto de las celdas
        ),
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

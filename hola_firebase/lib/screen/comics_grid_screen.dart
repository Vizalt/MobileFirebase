import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';
import 'package:hola_firebase/widgets/comic_widget.dart';

class ComicGridScreen extends StatefulWidget {
  const ComicGridScreen({Key? key}) : super(key: key);

  @override
  State<ComicGridScreen> createState() => _ComicGridScreenState();
}

class _ComicGridScreenState extends State<ComicGridScreen> {
  List<Comic>? comicList;

  @override
  void initState() {
    loadComicList().then((loadedComicList) {
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
        appBar: AppBar(title: const Text("Comic List")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Comic List")),
      body: ListView.separated(
        itemCount: comicList!.length,
        itemBuilder: (context, index) => ComicWidget(comic: comicList![index]),
        separatorBuilder: (context, index) =>
            const Divider(height: 1, indent: 70),
      ),
    );
  }
}

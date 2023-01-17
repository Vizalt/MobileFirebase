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
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
      ),
    );
  }
}

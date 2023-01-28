import 'package:flutter/material.dart';

import '../widgets/comic_saved_list.dart';

class ComicListScreen extends StatelessWidget {
  const ComicListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Comics'),
        backgroundColor: const Color.fromARGB(255, 197, 52, 41),
      ),
      backgroundColor: const Color.fromARGB(255, 71, 27, 25),
      body: const ComicSavedList(),
    );
  }
}

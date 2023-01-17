import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';
import 'package:hola_firebase/screen/comic_selected_screen.dart';

class ComicWidget extends StatelessWidget {
  const ComicWidget({
    Key? key,
    required this.comic,
  }) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 197, 52, 41).withAlpha(30),
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicSelectedScreen(
              comic: comic,
            ),
          ),
        );
      }),
      child: Stack(
        children: [
          Center(
            child: Image.network(
              '${comic.thumbnailPath}/standard_large.${comic.thumbnailExt}', // URL de la imagen
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
                  comic.title,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

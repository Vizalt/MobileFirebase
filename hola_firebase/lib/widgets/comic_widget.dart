import 'package:flutter/material.dart';
import 'package:hola_firebase/model/comics.dart';

class ComicWidget extends StatelessWidget {
  const ComicWidget({
    Key? key,
    required this.comic,
  }) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            '${comic.thumbnailPath}/portrait_xmedium.${comic.thumbnailExt}', // URL de la imagen
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(comic.title),
            //subtitle: Text(comic.description),
          ),
        ],
      ),

      /*leading: CircleAvatar(
        backgroundImage: NetworkImage(comic.thumbnail),
      ),*/
      /*title: Text(comic.title),
      subtitle: Text(comic.description),
      trailing: Text("${comic.pageCount}"),*/
      /*onTap: () {
        Navigator.of(context).pushNamed(
          '/user-details',
          arguments: user,
        );
      },*/
    );
  }
}

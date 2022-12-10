import 'dart:convert';
//import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

String privateKey = '5d0bbe1d51ed99bea321abc9012296e10fba755f';
String publicKey = '4f2186559bb378f4f73e573643459fe8';

class Comic {
  String title, description, format;
  int pageCount;
  //String publishDate;
  String thumbnailPath, thumbnailExt;

  Comic({
    required this.title,
    required this.description,
    required this.format,
    required this.pageCount,
    //required this.publishDate,
    required this.thumbnailPath,
    required this.thumbnailExt,
  });

  Comic.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        format = json["format"],
        pageCount = json["pageCount"],
        //publishDate = json["dates"]["date"],
        thumbnailPath = json["thumbnail"]["path"],
        thumbnailExt = json["thumbnail"]["extension"];
}

Future<List<Comic>> loadComicList([int numComics = 1]) async {
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  String concatenatedString = '$timeStamp$privateKey$publicKey';
  String hash = md5.convert(utf8.encode(concatenatedString)).toString();
  final url = Uri.parse(
      "https://gateway.marvel.com:443/v1/public/comics?limit=$numComics&hash=$hash&ts=$timeStamp&apikey=4f2186559bb378f4f73e573643459fe8");
  final response = await http.get(url);
  final json = jsonDecode(response.body);
  final List jsonComicList = json["data"]["results"];
  List<Comic> comicList = [];
  for (final jsonComic in jsonComicList) {
    comicList.add(Comic.fromJson(jsonComic));
  }
  return comicList;
}

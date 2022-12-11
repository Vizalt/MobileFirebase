import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

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

Future<List<Comic>> loadComicList(String hash, int timeStamp) async {
  int random = math.Random().nextInt(5) + 1;
  String orderBy = 'focDate';
  if (random == 1) {
    orderBy = 'focDate';
  }
  if (random == 2) {
    orderBy = 'onsaleDate';
  }
  if (random == 3) {
    orderBy = '-focDate';
  }
  if (random == 4) {
    orderBy = '-onsaleDate';
  }
  final url = Uri.parse(
      "https://gateway.marvel.com:443/v1/public/comics?formatType=collection&dateRange=2012-01-01%2C2013-01-02&orderBy=$orderBy&limit=15&ts=$timeStamp&apikey=$publicKey&hash=$hash");
  final response = await http.get(url);
  final json = jsonDecode(response.body);
  final List jsonComicList = json["data"]["results"];
  List<Comic> comicList = [];
  for (final jsonComic in jsonComicList) {
    comicList.add(Comic.fromJson(jsonComic));
  }
  return comicList;
}

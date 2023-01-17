import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

const privateKey = '5d0bbe1d51ed99bea321abc9012296e10fba755f';
const publicKey = '4f2186559bb378f4f73e573643459fe8';

class Comic {
  String title, description, format;
  int pageCount;
  String thumbnailPath, thumbnailExt;

  Comic({
    required this.title,
    required this.description,
    required this.format,
    required this.pageCount,
    required this.thumbnailPath,
    required this.thumbnailExt,
  });

  Comic.fromJson(Map<String, dynamic> json)
      : title = json["title"] ?? "No title",
        description = json["description"] ?? "No description",
        format = json["format"] ?? "No format",
        pageCount = json["pageCount"] ?? "No page count",
        thumbnailPath = json["thumbnail"]["path"] ?? "No image",
        thumbnailExt = json["thumbnail"]["extension"] ?? "No extension";
}

final rng = math.Random();

Future<List<Comic>> loadComicList() async {
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  String concatenatedString = '$timeStamp$privateKey$publicKey';
  String hash = md5.convert(utf8.encode(concatenatedString)).toString();
  int random = rng.nextInt(5) + 1;
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
  // final url2 = Uri.parse(
  //   "https://gateway.marvel.com:443/v1/public/comics?formatType=collection&dateRange=2012-01-01%2C2013-01-02&orderBy=$orderBy&limit=15&ts=$timeStamp&apikey=$publicKey&hash=$hash",
  // );
  final url = Uri(
    scheme: "https",
    host: "gateway.marvel.com",
    port: 443,
    path: "/v1/public/comics",
    queryParameters: {
      'formatType': 'collection',
      // 'dateRange': '2012-01-01,2013-01-02',
      'orderBy': orderBy,
      'limit': '50',
      'ts': timeStamp.toString(),
      'apikey': publicKey,
      'hash': hash,
    },
  );

  final response = await http.get(url);
  final json = jsonDecode(response.body);
  final List jsonComicList = json["data"]["results"];
  List<Comic> comicList = [];
  for (final jsonComic in jsonComicList) {
    comicList.add(Comic.fromJson(jsonComic));
  }
  return comicList;
}

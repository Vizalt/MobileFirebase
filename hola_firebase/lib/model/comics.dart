import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/src/widgets/container.dart';
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
        description = json["description"] ?? "No description available",
        format = json["format"] ?? "No format",
        pageCount = json["pageCount"] ?? "No page count",
        thumbnailPath = json["thumbnail"]["path"] ?? "No image",
        thumbnailExt = json["thumbnail"]["extension"] ?? "No extension";

  map(Container Function(dynamic item) param0) {}
}

final rng = math.Random();

Future<List<Comic>> loadComicList() async {
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  String concatenatedString = '$timeStamp$privateKey$publicKey';
  String hash = md5.convert(utf8.encode(concatenatedString)).toString();
  int random = rng.nextInt(10) + 1;
  int randomDate = rng.nextInt(12);
  String orderBy = 'focDate';
  String date = '2020';
  if (random == 1) {
    orderBy = 'focDate';
  }
  if (random == 2) {
    orderBy = 'onsaleDate';
  }
  if (random == 3) {
    orderBy = 'title';
  }
  if (random == 4) {
    orderBy = 'issueNumber';
  }
  if (random == 5) {
    orderBy = 'modified';
  }
  if (random == 6) {
    orderBy = '-focDate';
  }
  if (random == 7) {
    orderBy = '-onsaleDate';
  }
  if (random == 8) {
    orderBy = '-title';
  }
  if (random == 9) {
    orderBy = '-issueNumber';
  }
  if (random == 10) {
    orderBy = '-modified';
  }
  //Random Date
  if (randomDate == 0) {
    date = '2010';
  }
  if (randomDate == 1) {
    date = '2011';
  }
  if (randomDate == 2) {
    date = '2012';
  }
  if (randomDate == 3) {
    date = '2013';
  }
  if (randomDate == 4) {
    date = '2014';
  }
  if (randomDate == 5) {
    date = '2015';
  }
  if (randomDate == 6) {
    date = '2016';
  }
  if (randomDate == 7) {
    date = '2017';
  }
  if (randomDate == 8) {
    date = '2018';
  }
  if (randomDate == 9) {
    date = '2019';
  }
  if (randomDate == 10) {
    date = '2020';
  }
  if (randomDate == 11) {
    date = '2021';
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
      //'formatType': 'comic',
      'dateRange': '$date-01-01,2022-09-01',
      'orderBy': orderBy,
      'noVariants': 'true',
      'limit': '60',
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

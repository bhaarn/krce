import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/latestnews.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<LatestNews> latestNewsList = [];

Future<List<LatestNews>> viewLatestNews() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_LATEST_NEWS));

  latestNewsList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> latestNews = [];
    latestNews = jsonDecode(response.body);
    if (latestNews.length > 0) {
      for (int i = 0; i < latestNews.length; i++) {
        if (latestNews[i] != null) {
          Map<String, dynamic> map = latestNews[i];
          latestNewsList.add(LatestNews.fromJson(map));
        }
      }
    }
    return latestNewsList;
  } else {
    throw Exception(Strings.LATEST_NEWS_FAILED_EXCEPTION);
  }
}

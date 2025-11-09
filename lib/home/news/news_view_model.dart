import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/NewsResponse.dart';

class NewsViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;
  bool isLoading = false;

  Future<void> getNews({
    required String sourceId,
    required String query,
    required int page,
    required int pageSize,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final newsResponse = await ApiManger.getNews(
        sourceId: sourceId,
        q: query,
        page: page,
        pageSize: pageSize,
      );

      if (newsResponse.status == "error") {
        errorMessage = newsResponse.message ?? "Unknown error";
      } else {
        newsList = newsResponse.articles ?? [];
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/api/model/%20news/news_response.dart';
import 'package:news_app/api/model/source_response.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_services.g.dart';

@RestApi(baseUrl: 'https://newsapi.org')
abstract class RetrofitServices {
  factory RetrofitServices(Dio dio, {String? baseUrl}) = _RetrofitServices;

  @GET(EndPoints.sourceApi)
  Future<List<SourceResponse>> getSources(
      @Query("apiKey") String apiKey,
      @Query("category") String categoryId,
      );

  @GET(EndPoints.newsApi)
  Future<NewsResponse> getNews(
      @Query("apiKey") String apiKey,
      @Query("sources") String sourceId,
      );
}


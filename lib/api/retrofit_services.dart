import 'package:dio/dio.dart';
import 'package:news_app/api/end_points.dart';
import 'package:retrofit/retrofit.dart';

import 'model/ news/news_response.dart';
import 'model/source_response.dart';

part 'retrofit_services.g.dart';

@RestApi(baseUrl: 'https://newsapi.org')
abstract class RetrofitServices {
  factory RetrofitServices(Dio dio, {String? baseUrl}) = _RetrofitServices;

  @GET(EndPoints.sourceApi)
  Future<SourceResponse> getSources(
      @Query("apiKey") String apiKey,
      @Query("category") String categoryId,
      );

  @GET(EndPoints.newsApi)
  Future<NewsResponse> getNews(
      @Query("apiKey") String apiKey,
      @Query("sources") String sourceId,
      );
}


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';
import 'package:dio/dio.dart';

import 'dio_interceptor.dart';
class DioApiManger{
  //https://newsapi.org/v2/top-headlines/sources?apiKey=6c3d95648f21488da14510b0df98ffac
  final Dio dio=Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org",
      // queryParameters: {
      //   "apiKey":ApiConstants.apiKey,
      // },
    )
  );

  DioApiManger(){
    dio.interceptors.add(DioInterceptor());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        filter: (options, args){
          // don't print requests with uris containing '/posts'
          if(options.path.contains('/posts')){
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }
    )
    );
  }
  Future<SourceResponse> getSources({required String categoryId}) async {
    try{
      var response=await  dio.get(EndPoints.sourceApi,
          queryParameters: {
            "category":categoryId
          },
          );
      var json=response.data;
      return SourceResponse.fromJson(json);
    }
    catch(e){
      rethrow;
    }

  }
//GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=6c3d95648f21488da14510b0df98ffac
  Future<NewsResponse> getNews({String sourceId="",String q=""}) async {
    try{
      var response=await dio.get(EndPoints.newsApi,
          queryParameters: {
            "sources":sourceId,
            "q":q
          });
      var json=response.data;
      return NewsResponse.fromJson(json);
    }
    catch(e){
      rethrow;
    }

  }
}
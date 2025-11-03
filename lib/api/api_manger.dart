import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/end_points.dart';

import 'api_constants.dart';
import 'model/ news/news_response.dart';
import 'model/source.dart';
class ApiManger{
  //https://newsapi.org/v2/top-headlines/sources?apiKey=6c3d95648f21488da14510b0df98ffac
  static Future<Source> getSources({required String categoryId, String q="" }) async {
    Uri url=Uri.https(ApiConstants.baseUrl,EndPoints.sourceApi, {
      "apiKey": ApiConstants.apiKey,
      "category":categoryId,
      "q":q
    });
    try{
      var response=await http.get(url);
      // String responseBody= response.body;  //string to json >>>>>>json to object
      // var json= jsonDecode(responseBody);
      // Source.fromJson(json);
      return Source.fromJson(jsonDecode(response.body));
    }
    catch(e){
      rethrow ;
    }

  }

  static Future<NewsResponse> getNews({String sourceId="",String q=""}) async {
    Uri uri=Uri.https(ApiConstants.baseUrl,EndPoints.newsApi,{
      "apiKey":ApiConstants.apiKey,
      "sources":sourceId,
      "q":q

    });
 try{
   var response= await http.get(uri);
   var responseBody=response.body;
   var  json=jsonDecode(responseBody);
   return NewsResponse.fromJson(json);
 }catch(e){
   rethrow ;
     }
  }
}
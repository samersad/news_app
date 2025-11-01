import 'package:dio/dio.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/app_exception.dart';

class DioInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    print(options.baseUrl);
    options.headers.addAll({
      "X-Api-Key":ApiConstants.apiKey
    });
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(response.statusCode);
    super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    String message="Something went wrong, please try again";
    try{
      if (err.response!.data is Map&&
          err.response!.data.containsKey("message")) {
        message=err.response!.data["message"];
      }
      else{
        switch(err.type){
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.connectionError:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            message="Connection timeout. Please check your internet connection";
              break;
          case DioExceptionType.badResponse:
            message="Failed to load data. status code${err.response?.statusCode}";
            break;
          case DioExceptionType.cancel:
            message="Request was canceled";
            break;
            case DioExceptionType.unknown:
            message="An unknow network error";
            break;
          default:
            message="An unknow  error";
            break;
        }
      }
    }catch(e){
      message="An unexpected error occurred:${e.toString()}";
    }
    handler.next(
    DioException(requestOptions: err.requestOptions,
        error: AppException(message: message),
        message: message,
        response: err.response
    ));
  }
  }

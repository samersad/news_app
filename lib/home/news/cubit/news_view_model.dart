import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/news/cubit/news_states.dart';
import '../../../model/NewsResponse.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsViewModel() : super(NewsInitialState());

  Future<void> getNewsBySourceId({
    required String sourceId,
    String q = "",
    int page = 1,
    int pageSize = 20,
  }) async {
    emit(NewsLoadingState());
    try {
      final response = await ApiManger.getNews(
        sourceId: sourceId,
        q: q,
        page: page,
        pageSize: pageSize,
      );

      if (response.status == "error") {
        emit(NewsErrorState(errorMessage:response.message!));
      } else {
        emit(NewsSuccessState(newsList: response.articles ?? []));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage:e.toString()));
    }
  }
}

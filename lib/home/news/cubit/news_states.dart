import '../../../model/NewsResponse.dart';

abstract class NewsStates {}
class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsSuccessState extends NewsStates {
  final List<News> newsList;
  NewsSuccessState({required this.newsList});
}

class NewsErrorState extends NewsStates {
  final String errorMessage;

  NewsErrorState({required this.errorMessage});
}

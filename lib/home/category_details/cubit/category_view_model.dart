import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'category_states.dart';
class CategoryViewModel extends Cubit<CategoryState>{
  CategoryViewModel():super(CategoryLoadingState());
  List<Source>? sourcesList;
  String? errorMessage;
  int selectedIndex=0;
  Future<void> getSources({required String categoryId}) async {
    try{
      emit(CategoryLoadingState());
    var response= await ApiManger.getSources(categoryId: categoryId);
      if (response.status=="error") {
        emit(CategoryErrorState());
        errorMessage=response.message!;
      }
     else if (response.status=="ok") {
        emit(CategorySuccessState());
      sourcesList=response.sources!;
      }
    }catch(e){
      emit(CategoryErrorState());
      errorMessage=e.toString();
    }
  }
  void changeSelectedIndex(int index){
    selectedIndex=index;
    emit(ChangeSelectedIndexState());
  }
}
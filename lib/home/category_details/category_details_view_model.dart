import 'package:flutter/cupertino.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/SourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier{
  List<Source>? sourceList ;
  String? errorMessage;
  void getSource(String categoryId )async{
    //reinitialize
    sourceList=null;
    errorMessage=null;
    notifyListeners();
    try{
      var sourceResponse=await  ApiManger.getSources(categoryId: categoryId);
      if (sourceResponse.status == "error") {
        errorMessage=sourceResponse.message ;

      }
      else{
        sourceList=sourceResponse.sources;
      }
    }catch(e)
    {errorMessage=e.toString();}
    notifyListeners();
  }


}
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../model/SourceResponse.dart';
import '../../model/category.dart';

class CategoryDetails extends StatefulWidget {
   CategoryDetails({super.key ,required this.category});
  final Category category;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
        future: ApiManger.getSources(categoryId:widget.category.id, ),  // get api
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppColors.greyColor,),);
          }
          else if (snapshot.hasError) { // error from  client
            return Column(
              children: [
                Text("something went wrong"),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.greyColor),
                    onPressed: (){ApiManger.getSources(categoryId: widget.category.id, );
                  setState(() {

                  });}, child: Text("Try Again",
                  style: Theme.of(context).textTheme.labelMedium,))
              ],
            );
          }
          if (snapshot.data?.status!="ok") { // error from server
            return Column(
              children: [
                Text(snapshot.data!.message!),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.greyColor),
                    onPressed: (){ApiManger.getSources(categoryId: widget.category.id, );
                      setState(() {

                      });
                  }, child: Text("Try Again",
                      style: Theme.of(context).textTheme.labelMedium,))
              ],
            );
          }
          List<Source>? sourceList=snapshot.data?.sources?? [];
          return SourceTapWidget(sourcesList: sourceList);
        },);
  }
}

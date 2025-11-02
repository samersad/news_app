import 'package:flutter/material.dart';
import 'package:news_app/home/category_fragment/category_item.dart';

import '../../model/category.dart';

typedef onCategorylick=void Function(Category);
class CategoryFragment extends StatelessWidget {
   CategoryFragment({super.key,required this.onCategoryItemClick});
   onCategorylick onCategoryItemClick;
  List<Category> categoryList =[];
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    categoryList=Category.getCategoryList(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good Morning\nHere is Some News For You",
            style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: height*0.01,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        onCategoryItemClick(categoryList[index]);
                      },
                      child: CategoryItem(category: categoryList[index],index: index,));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.02);
                },
                itemCount: 7),
          )
        ],
      ),
    );
  }
}

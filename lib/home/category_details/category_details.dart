import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/app_exception.dart';
import 'package:news_app/api/dio_api_manger.dart';
import 'package:news_app/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../model/SourceResponse.dart';
import '../../model/category.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: DioApiManger().getSources(categoryId: widget.category.id), // get api
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          String errorMessage;

          if (snapshot.error is DioException &&
              (snapshot.error as DioException).error is AppException) {
            errorMessage =
                ((snapshot.error as DioException).error as AppException)
                    .message;
          }
          else {
            errorMessage = snapshot.error.toString();
          }
          // error from  client
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(errorMessage, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  DioApiManger().getSources(categoryId: widget.category.id);
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,
                ),
              ),
            ],
          );
        }
        else if (snapshot.hasData) {
          List<Source>? sourceList = snapshot.data?.sources ?? [];
          if (sourceList == null || sourceList.isEmpty) {
            return Center(child: Text("No sources found",
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,),);
          }
          else {
            return SourceTapWidget(sourcesList: sourceList);
          }
          }
        else{
          return Center(child: Text("Starting fetching source"));
        }
      },
    );
  }
}

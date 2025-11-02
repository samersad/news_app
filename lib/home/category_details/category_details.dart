import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/api/retrofit_services.dart';
import 'package:news_app/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../model/SourceResponse.dart';
import '../../model/category.dart';
import 'package:dio/dio.dart';
class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.category, required this.searchQuery});
  final Category category;
  final String searchQuery; // 👈 هنا

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RetrofitServices(Dio()).getSources(ApiConstants.apiKey,
          widget.category.id), // get api
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          // error from  client
          return Column(
            children: [
              Text("something went wrong"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  ApiManger.getSources(categoryId: widget.category.id);
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }
        if (snapshot.data?.status != "ok") {
          // error from server
          return Column(
            children: [
              Text(snapshot.data!.message!),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  ApiManger.getSources(categoryId: widget.category.id);
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }
        List<Source>? sourceList = snapshot.data?.sources ?? [];
        return SourceTapWidget(sourcesList: sourceList,
          searchQuery: widget.searchQuery,
        );
      },
    );
  }
}

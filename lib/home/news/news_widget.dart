import 'package:flutter/material.dart';
import 'package:news_app/home/news/buttomSheet.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../api/dio_api_manger.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: DioApiManger().getNews(sourceId: widget.source.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("something went wrong",style: Theme.of(context).textTheme.headlineMedium,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  DioApiManger().getNews(sourceId: widget.source.id ?? "");
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
        if (snapshot.data!.status != "ok") {
          return Column(
            children: [
              Text(snapshot.data!.message!),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  DioApiManger().getNews(sourceId: widget.source.id ?? "");
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
        var newsList = snapshot.data!.articles ?? [];
        return ListView.separated(
          padding: EdgeInsets.only(top: height * 0.02),
          separatorBuilder: (context, index) {
            return SizedBox(height: height * 0.02);
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                NewsBottomSheet.showButtonSheet(context, newsList[index]);
              },
              child: NewsItem(news: newsList[index]),
            );
          },
          itemCount: newsList.length,
        );
      },
    );
  }
}

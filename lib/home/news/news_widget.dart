import 'package:flutter/material.dart';
import 'package:news_app/home/news/buttomSheet.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';
import '../../api/api_manger.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  final String searchQuery;

  const NewsWidget({
    super.key,
    required this.source,
    required this.searchQuery
  });

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.getNews(
        sourceId: widget.source.id ?? "",
        q: widget.searchQuery,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return _buildError("Something went wrong");
        }

        if (snapshot.data?.status != "ok") {
          return _buildError(snapshot.data?.message ?? "Server error");
        }

        var newsList = snapshot.data!.articles ?? [];
        return ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
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

  Widget _buildError(String message) {
    return Column(
      children: [
        Text(message),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greyColor,
          ),
          onPressed: () {
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
}

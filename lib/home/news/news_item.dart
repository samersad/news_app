import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../api/model/ news/news.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    DateTime? publishedTime;
        publishedTime = DateTime.parse(news.publishedAt!);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).splashColor, width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? "",
                placeholder: (context, url) =>
                    CircularProgressIndicator(color: AppColors.greyColor),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColors.greyColor),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              news.title ?? "",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "By : ${news.author ?? ""}",
                    style: AppStyles.medium12Gray,
                  ),
                ),
                Text(
                  timeago.format(publishedTime),

                  style: AppStyles.medium12Gray,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/model/ news/news.dart';
import '../../utils/app_colors.dart';

class NewsBottomSheet {
  static void showButtonSheet(BuildContext context, News news) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            left: width * 0.045,
            right: width * 0.045,
            bottom: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(12),
          ),
          height: height * 0.48,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? "",
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greyColor,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: AppColors.greyColor),
                ),
              ),
               SizedBox(height: height*0.012),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    news.content ?? 'No content',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              SizedBox(height: height*0.012),

              ElevatedButton(
                // launchUrl need uri ana m3ya String  fa ahol men String to uri by parse
                onPressed: () async {
             final Uri uri = Uri.parse(news.url ?? "");

             await launchUrl(uri, mode: LaunchMode.inAppWebView);
            },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "View Full Article",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ],
          ),
        );
      },
    );
  }

}

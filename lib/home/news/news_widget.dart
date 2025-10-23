import 'package:flutter/material.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../api/api_manger.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key,required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: ApiManger.getNews(widget.source.id??""),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppColors.greyColor,),);
          }
          else if (snapshot.hasError) {
            return  Column(
              children: [
                Text("something went wrong"),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.greyColor),
                    onPressed: (){ApiManger.getNews(widget.source.id??"");
                  setState(() {

                  });
                  }, child: Text("Try Again",
                      style: Theme.of(context).textTheme.labelMedium,))
              ],
            );
            
          }
          if (snapshot.data!.status!="ok") {
            return Column(
              children: [
                Text(snapshot.data!.message!),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.greyColor),
                    onPressed: (){ApiManger.getNews(widget.source.id??"");
                    setState(() {

                    });}, child: Text("Try Again",
                      style: Theme.of(context).textTheme.labelMedium,))
              ],
            );
          }
          var newsList=snapshot.data!.articles ??[];
          return ListView.builder(itemBuilder: (context, index) {
            return Text(newsList[index].title??"",style: Theme.of(context).textTheme.labelMedium,);
          },
            itemCount: newsList.length,
          );
        },);
  }
}

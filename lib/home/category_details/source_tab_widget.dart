import 'package:flutter/material.dart';
import 'package:news_app/home/category_details/widget/source_name.dart';
import 'package:news_app/home/news/news_widget.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../api/model/source.dart';

class SourceTapWidget extends StatefulWidget {
   SourceTapWidget({super.key,required this.sourcesList, required this.searchQuery,});
    List<Source> sourcesList;
   final String searchQuery;


   @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}

class _SourceTapWidgetState extends State<SourceTapWidget> {
     int   selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
          child: Column(
          children: [
            TabBar(indicatorColor: Theme.of(context).splashColor,
                dividerColor: AppColors.transparentColor,
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  selectedIndex=index;
                  setState(() {

                  });
                },
                isScrollable: true,tabs: widget.sourcesList.map((source) {
              return SourceName(source: source, isSelected: selectedIndex==widget.sourcesList.indexOf(source));
            },).toList()
            ),
            Expanded(child: NewsWidget(source: widget.sourcesList[selectedIndex],
                searchQuery: widget.searchQuery))
          ],

        ));
  }
}

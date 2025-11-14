import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/category_details/widget/source_name.dart';
import 'package:news_app/home/news/news_widget.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';

import 'cubit/category_view_model.dart';

class SourceTapWidget extends StatefulWidget {
   SourceTapWidget({super.key,required this.sourcesList, required this.searchQuery,});
    List<Source> sourcesList;
   final String searchQuery;
   @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}
class _SourceTapWidgetState extends State<SourceTapWidget> {
  @override
  Widget build(BuildContext context) {
   var viewModel=BlocProvider.of<CategoryViewModel>(context);
    return DefaultTabController(
        length: widget.sourcesList.length,
          child: Column(
          children: [
            TabBar(indicatorColor: Theme.of(context).splashColor,
                dividerColor: AppColors.transparentColor,
                tabAlignment: TabAlignment.start,
                onTap: (index) {
              viewModel.changeSelectedIndex(index);
                },
                isScrollable: true,tabs: widget.sourcesList.map((source) {
              return SourceName(source: source, isSelected:viewModel.selectedIndex==widget.sourcesList.indexOf(source));
            },).toList()
            ),
            Expanded(child: NewsWidget(source: widget.sourcesList[viewModel.selectedIndex],
                searchQuery: widget.searchQuery))
          ],

        ));
  }
}

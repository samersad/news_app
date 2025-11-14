import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/news/buttomSheet.dart';
import 'package:news_app/home/news/cubit/news_states.dart';
import 'package:news_app/home/news/cubit/news_view_model.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  final String searchQuery;
  const NewsWidget({
    super.key,
    required this.source,
    required this.searchQuery,
  });
  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}
class _NewsWidgetState extends State<NewsWidget> {
   NewsViewModel viewModel =NewsViewModel();
  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {    //build when we change source or search
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id ||
        oldWidget.searchQuery != widget.searchQuery) {
      viewModel.getNewsBySourceId(
        sourceId: widget.source.id ?? "",
        q: widget.searchQuery,
      );
    }
  }

   @override
   Widget build(BuildContext context) {     //build first time  =initState fun
     Future.microtask(() {
       if (viewModel.state is NewsInitialState) {
         viewModel.getNewsBySourceId(
           sourceId: widget.source.id ?? "",
           q: widget.searchQuery,
         );
       }
     });

     return BlocConsumer<NewsViewModel, NewsStates>(
       bloc: viewModel,
       listener: (context, state) {},
       builder: (context, state) {
         if (state is NewsLoadingState) {
           return const Center(
             child: CircularProgressIndicator(color: AppColors.greyColor),
           );
         } else if (state is NewsErrorState) {
           return _buildError(state.errorMessage);
         } else if (state is NewsSuccessState) {
           return ListView.builder(
             padding: const EdgeInsets.only(top: 10),
             itemCount: state.newsList.length,
             itemBuilder: (context, index) {
               return InkWell(
                 onTap: () => NewsBottomSheet.showButtonSheet(
                     context, state.newsList[index]),
                 child: NewsItem(news: state.newsList[index]),
               );
             },
           );
         }
         return const SizedBox.shrink();
       },
     );
   }


  Widget _buildError(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greyColor,
          ),
          onPressed: () {
            viewModel.getNewsBySourceId(
              sourceId: widget.source.id ?? "",
              q: widget.searchQuery,
            );
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

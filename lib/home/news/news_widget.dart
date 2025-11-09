import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/news/buttomSheet.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/home/news/news_view_model.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

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
  static const _pageSize = 20;

  final PagingController<int, News> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id ||
        oldWidget.searchQuery != widget.searchQuery) {
      _pagingController.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newsResponse = await ApiManger.getNews(
        sourceId: widget.source.id ?? "",
        q: widget.searchQuery,
        page: pageKey,
        pageSize: _pageSize,
      );

      final newItems = newsResponse.articles ?? [];
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel(),
      child: Consumer<NewsViewModel>(
          child: Text("News",style:AppStyles.bold16Black,),
          builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return _buildError(context, viewModel.errorMessage!);
          }
          return PagedListView<int, News>(
            pagingController: _pagingController,
            padding: const EdgeInsets.only(top: 10),
            builderDelegate: PagedChildBuilderDelegate<News>(
              itemBuilder: (context, article, index) => InkWell(
                onTap: () =>
                    NewsBottomSheet.showButtonSheet(context, article),
                child: Column(
                  children: [
                    child!,
                    NewsItem(news: article),
                  ],
                ),
              ),
              newPageProgressIndicatorBuilder: (context) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: AppColors.redColor),
                      SizedBox(height: 8),
                      Text("Loading...")
                    ],
                  ),
                ),
              ),
              newPageErrorIndicatorBuilder: (context) =>
                  _buildError(context, "Failed to load more news"),
            ),
          );
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyColor,
            ),
            onPressed: () {
              _pagingController.refresh();
            },
            child: Text(
              "Try Again",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

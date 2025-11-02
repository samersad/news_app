import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/news/buttomSheet.dart';
import 'package:news_app/model/NewsResponse.dart';
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
  static const _pageSize = 20;

  final PagingController<int, News> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, News>(
      pagingController: _pagingController,
      padding: const EdgeInsets.only(top: 10),
      builderDelegate: PagedChildBuilderDelegate<News>(
        itemBuilder: (context, article, index) => InkWell(
          onTap: () => NewsBottomSheet.showButtonSheet(context, article),
          child: NewsItem(news: article),
        ),
        newPageProgressIndicatorBuilder: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Column(
            children: [
              CircularProgressIndicator(color: AppColors.redColor),
              Text("Loading"
              )
            ],
          )
          ),
        ),
        firstPageErrorIndicatorBuilder: (context) => _buildError("Something went wrong"),
        newPageErrorIndicatorBuilder: (context) => _buildError("Failed to load more news"),
      ),
    );
  }
  Widget _buildError(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greyColor,
          ),
          onPressed: () {
            ApiManger.getNews(sourceId: widget.source.id ?? "",
              q: widget.searchQuery,);
            _pagingController.refresh();
          },
          child: Text(
            "Try Again",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

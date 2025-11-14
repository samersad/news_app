import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/category_details/cubit/category_states.dart';
import 'package:news_app/home/category_details/cubit/category_view_model.dart';
import 'package:news_app/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

import '../../model/SourceResponse.dart';
import '../../model/category.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({
    super.key,
    required this.category,
    required this.searchQuery,
  });

  final Category category;
  final String searchQuery;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryViewModel viewModel = CategoryViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(categoryId: widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => viewModel,      //if many screens use
      child: BlocBuilder<CategoryViewModel, CategoryState>(
      //  bloc: viewModel,          //if one screen use like this project
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.greyColor),
            );
          } else if (state is CategoryErrorState) {
            return Column(
              children: [
                Text(viewModel.errorMessage!, style: Theme.of(context).textTheme.headlineMedium), ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    viewModel.getSources(categoryId: widget.category.id);
                  },
                  child: Text(
                    "Try Again",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            );
          } else {
            return SourceTapWidget(sourcesList: viewModel.sourcesList!, searchQuery: widget.searchQuery,);
          }
        },
      ),
    );

  }
}

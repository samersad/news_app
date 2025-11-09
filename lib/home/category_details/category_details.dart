import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/home/category_details/category_details_view_model.dart';
import 'package:news_app/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../model/SourceResponse.dart';
import '../../model/category.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.category, required this.searchQuery});
  final Category category;
  final String searchQuery; // 👈 هنا

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  CategoryDetailsViewModel viewModel=CategoryDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSource(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => viewModel,
      child: Consumer<CategoryDetailsViewModel>(builder: (context, viewModel, child) {
        if (viewModel.errorMessage!=null) {
                return Column(
                  children: [
                    Text(viewModel.errorMessage!,style: Theme.of(context).textTheme.headlineMedium,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greyColor,
                      ),
                      onPressed: () {
                        viewModel.getSource(widget.category.id);
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
        else if (viewModel.sourceList==null) {
          //loading
                return Center(
                  child: CircularProgressIndicator(color: AppColors.greyColor),
                );
        }
        else{
              return SourceTapWidget(sourcesList: viewModel.sourceList!, searchQuery: widget.searchQuery);

        }
      },)

    );
  }
}

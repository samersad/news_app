import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/NewsResponse.dart';
import '../model/category.dart';
import '../utils/custom_text_form_field.dart';
import 'category_details/category_details.dart';
import 'category_fragment/category_fragment.dart';
import 'drawer/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchOpen = false;
  final TextEditingController searchController = TextEditingController();
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: selectedCategory == null ?
        SizedBox()
            :
        isSearchOpen
            ? CustomTextFormField(
          onChanged: (_) {
            setState(() {

            });
          },
          controller: searchController,
          hintText: "Search...",
          prefixIconName: Icon(
            Icons.search,
            color: Theme.of(context).splashColor,
          ),
          suffixIconName: IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).splashColor),
            onPressed: () {
              setState(() {
                isSearchOpen = false;
                searchController.clear();
              });
            },
          ),
        )
            : Text(
          selectedCategory == null ? "Home" : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        actions: [
          if (!isSearchOpen)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearchOpen = true;
                });
              },
              icon: Icon(
                Icons.search, size: 30, color: Theme.of(context).splashColor,
              ),
            ),
        ],
      ),

      drawer: DrawerWidget(onDrawerItemClick: onDrawerItemClick),

      body: selectedCategory == null
          ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
          : CategoryDetails(
        category: selectedCategory!,
        searchQuery: searchController.text,
      ),    );
  }

  void onCategoryItemClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onDrawerItemClick() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
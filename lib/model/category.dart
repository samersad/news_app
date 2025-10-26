import 'package:flutter/material.dart';
import 'package:news_app/utils/assets_manger.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Category {
  String id;
  String title;
  String image;
  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoryList(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return [
      Category(
        id: "general",
        title: "General",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.generalDarkImage
            : AssetsManager.generalLightImage,
      ),
      Category(
        id: "business",
        title: "Business",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.businessDarkImage
            : AssetsManager.businessLightImage,
      ),
      Category(
        id: "sports",
        title: "Sports",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.sportsDarkImage
            : AssetsManager.sportsLightImage,
      ),
      Category(
        id: "technology",
        title: "Technology",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.technologyDarkImage
            : AssetsManager.technologyLightImage,
      ),
      Category(
        id: "entertainment",
        title: "Entertainment",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.entertainmentDarkImage
            : AssetsManager.entertainmentLightImage,
      ),
      Category(
        id: "health",
        title: "Health",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.healthDarkImage
            : AssetsManager.healthLightImage,
      ),
      Category(
        id: "science",
        title: "Science",
        image: themeProvider.appTheme == ThemeMode.dark
            ? AssetsManager.scienceDarkImage
            : AssetsManager.scienceLightImage,
      ),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/home/drawer/theme_buttom_sheet.dart';
import 'package:news_app/home/drawer/theme_lanaguage_container.dart';
import 'package:news_app/home/drawer/drawer_item.dart';
import 'package:news_app/utils/assets_manger.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'divider_item.dart';
import 'language_button_sheet.dart';

class DrawerWidget extends StatefulWidget {
   DrawerWidget({super.key,required this.onDrawerItemClick});
  VoidCallback onDrawerItemClick ;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var themeProvider=Provider.of<ThemeProvider>(context);

    return Drawer(backgroundColor: AppColors.blackColor,
      child: Column(
        children: [
          Container(
            width: width,
            height: height*0.25,
            alignment: Alignment.center,
            color: AppColors.whiteColor,
            child: Text("News App",style: AppStyles.bold24Black,),
          ),
          InkWell(onTap: () {
            widget.onDrawerItemClick();
          },
              child: DrawerItem(text: "Go To Home",iconName: AssetsManager.homeIcon,)),
           DividerItem(),
           DrawerItem(text: "Theme" ,iconName: AssetsManager.themeIcon,),
          InkWell(onTap: () {
            showBottomSheetTheme();
          }
              ,child: ThemeLanaguageContainer(text: themeProvider.appTheme==ThemeMode.light?
              "Light":
              "Dark")),
          DividerItem(),
          DrawerItem(text: "language",iconName: AssetsManager.languageIcon,),
          InkWell(onTap: () {
            showBottomSheetLanguage();
          }
              ,child: ThemeLanaguageContainer(text: "English",)),



        ],
      ),);
  }

  void showBottomSheetTheme(){
    showModalBottomSheet(context: context, builder: (context) {
      return ThemeButtonSheet();
    },
    );
  }
  void showBottomSheetLanguage(){
    showModalBottomSheet(context: context, builder: (context) {
      return LanguageButtonSheet();
    },
    );
  }
}

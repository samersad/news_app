
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class ThemeButtonSheet extends StatefulWidget {
  const ThemeButtonSheet({super.key});

  @override
  State<ThemeButtonSheet> createState() => _ThemeButtonSheetState();
}

class _ThemeButtonSheetState extends State<ThemeButtonSheet> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
      child: Column(
        spacing: height*0.01,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap:
                  () {
                themeProvider.changeTheme(ThemeMode.light);

              },
              child: themeProvider.appTheme==ThemeMode.light?
              getSelectedItem(theme: "Light")
                  :
              getUnSelectedItem(theme: "Light")
          ),
          InkWell(
              onTap: () {

                themeProvider.changeTheme(ThemeMode.dark);

              },
              child:  themeProvider.appTheme==ThemeMode.dark?
              getSelectedItem(theme:"Dark")
                  :
              getUnSelectedItem(theme: "Dark")
          )
        ],
      ),
    );
  }
  Widget getSelectedItem({required String theme}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme,style: AppStyles.bold20Black,),
        Icon(Icons.check,color: AppColors.blackColor,)
      ],
    );
  }

  Widget getUnSelectedItem({required String theme}){
    return Text(theme,style: AppStyles.bold20Black,);
  }
}

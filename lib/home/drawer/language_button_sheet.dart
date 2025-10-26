
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class LanguageButtonSheet extends StatefulWidget {
  const LanguageButtonSheet({super.key});

  @override
  State<LanguageButtonSheet> createState() => _LanguageButtonSheetState();
}

class _LanguageButtonSheetState extends State<LanguageButtonSheet> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
      child: Column(
        spacing: height*0.01,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap:
                  () {

              },
              child: Text("English")
          ),
          InkWell(
              onTap: () {


              },
              child:   Text("Arabic")
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

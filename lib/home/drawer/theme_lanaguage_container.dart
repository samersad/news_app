import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class ThemeLanaguageContainer extends StatelessWidget {
   ThemeLanaguageContainer({super.key,required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(left:  width*0.02,right: width*0.02,bottom: height*0.02),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.04),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.whiteColor,width: 2),
            color: AppColors.transparentColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,style: AppStyles.medium20White,),
            Icon(Icons.arrow_drop_down_outlined,size: 35,color: AppColors.whiteColor,)
          ],
        ),
      ),
    );

  }
}

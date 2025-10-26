import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class DividerItem extends StatelessWidget {
  const DividerItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Divider(
      color: AppColors.whiteColor,
      indent: width * 0.04,
      endIndent: width * 0.04,
      thickness: 2,
    );
  }
}

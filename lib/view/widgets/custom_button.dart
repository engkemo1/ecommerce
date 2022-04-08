import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedFn;

  CustomButton(this.text, this.onPressedFn);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressedFn,
      child:Container(
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: p,

        ),
        width: 140,
      child: CustomText(
        text: text,
        fontSize: 14,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    ));
  }
}

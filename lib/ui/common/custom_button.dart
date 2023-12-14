import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import 'text_style.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String name;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.width, required this.name, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 8, right: 8, bottom: 8, top: 8),
      child: Container(
        height: 48,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.primarySwitch,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: onPressed,
            child: Center(
              child: Text(
                name,
                style: buttonTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final bool iconButtonShowing;
  final Function onPressed;
  final int iconButtonShowingMillisecondTime;
  final IconData icon;

  const CustomIconButton({
    Key? key,
    this.iconButtonShowing = true,
    this.iconButtonShowingMillisecondTime = 200,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: iconButtonShowing,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.amberAccent.shade200,
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: Icon(
            icon,
            size: 70,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

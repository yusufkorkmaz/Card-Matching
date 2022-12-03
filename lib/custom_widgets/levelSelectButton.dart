import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelSelectButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const LevelSelectButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.amber,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

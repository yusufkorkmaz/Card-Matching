import 'package:flutter/material.dart';

class LevelSelectButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const LevelSelectButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<LevelSelectButton> createState() => _LevelSelectButtonState();
}

class _LevelSelectButtonState extends State<LevelSelectButton> {
  late double buttonPosition;

  @override
  void initState() {
    buttonPosition = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTapUp: (_) {
          setState(() {
            buttonPosition = 0;
          });
        },
        onTapDown: (_) {
          setState(() {
            buttonPosition = 10;
          });
        },
        onTapCancel: () {
          setState(() {
            buttonPosition = 0;
          });
        },
        onTap: widget.onPressed,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: buttonPosition,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(fontSize: 21, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

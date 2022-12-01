import 'package:flutter/material.dart';
import 'dart:math' as math; // import this

typedef void StringCallback(String val);

class CustomCard extends StatefulWidget {
  int cardIndex;
  String imageName;
  bool isClickable;
  bool isImageShowing;
  Function clickedCardNameFunc;
  double transformVar = 0;

  CustomCard({
    Key? key,
    this.isClickable = true,
    required this.isImageShowing,
    required this.cardIndex,
    required this.imageName,
    required this.clickedCardNameFunc,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  onClickedCard() {
    setState(() => {
          widget.clickedCardNameFunc(widget),
          widget.transformVar = math.pi,
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isClickable ? onClickedCard : () => {},
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        margin: const EdgeInsets.all(8),
        child: AnimatedOpacity(
                opacity: widget.isImageShowing ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  'lib/images/${widget.imageName}',
                  width: 50,
                  height: 50,
                ),
              )
      ),
    );
  }
}

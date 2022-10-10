import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class CustomCard extends StatefulWidget {
  int cardIndex;
  String imageName;
  bool isClickable;
  bool isImageShowed;
  Function clickedCardNameFunc;

  CustomCard({
    Key? key,
    this.isClickable = true,
    this.isImageShowed = false,
    required this.cardIndex,
    required this.imageName,
    required this.clickedCardNameFunc,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  onClickedCard() {
    setState(() => {widget.clickedCardNameFunc(widget)});
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.isClickable ? onClickedCard : () => {},
      child: Visibility(
        visible: widget.isImageShowed,
        child: Image.asset(
          'lib/images/${widget.imageName}',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}

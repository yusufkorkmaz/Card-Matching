import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class CustomCard extends StatefulWidget {
  int cardIndex;
  String imageName;
  bool isClickable;
  bool isImageShowing;
  Function clickedCardNameFunc;

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
    setState(() => {widget.clickedCardNameFunc(widget)});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isClickable ? onClickedCard : () => {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        margin: const EdgeInsets.all(8),
        child: widget.isImageShowing
            ? Image.asset(
                'lib/images/${widget.imageName}',
                width: 50,
                height: 50,
              )
            : Container(),
      ),
    );
  }
}

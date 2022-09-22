import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class CustomCard extends StatefulWidget {
  final String imageName;
  final Function clickedCardNameFunc;

  const CustomCard({
    Key? key,
    required this.imageName,
    required this.clickedCardNameFunc,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isImageShowed = false;

  onClickedCard() {
    widget.clickedCardNameFunc(widget.imageName);
    setState(() => {
      isImageShowed = !isImageShowed,
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClickedCard,
      child: Visibility(
        visible: isImageShowed,
        child: Image.asset(
          'lib/images/${widget.imageName}',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}

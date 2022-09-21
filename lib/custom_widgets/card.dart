import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String imageName;

  const CustomCard({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isImageShowed = false;

  onClickedCard() {
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

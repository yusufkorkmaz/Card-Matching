import 'dart:math';

import 'package:card_matching/custom_widgets/card.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String appHeader;

  const GamePage({Key? key, required this.appHeader}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int maxImagesNumberInImagesFolder = 5;

  static int get getTotalCardCount => 6;
  var randomNumber = Random();
  var cardsOnScreen = List<Widget>.filled(getTotalCardCount, Container());
  String clickedCardName = '';
  int clickedCardIndex = 0;
  int score = 0;
  List<CustomCard> clickedCards = [];

  randomImageNumberChoose() {
    List<int> randomImageNumbers = [];
    for (int i = 0; i < getTotalCardCount / 2; i++) {
      int randomImageNumber =
          randomNumber.nextInt(maxImagesNumberInImagesFolder) + 1;
      if (randomImageNumbers.contains(randomImageNumber)) {
        i--;
      } else {
        randomImageNumbers.add(randomImageNumber);
      }
    }
    return randomImageNumbers;
  }

  randomIndexNumberChoose() {
    List<int> randomIndexNumbers = [];
    for (int i = 0; i < getTotalCardCount; i++) {
      int randomIndexNumber = randomNumber.nextInt(getTotalCardCount);
      if (randomIndexNumbers.contains(randomIndexNumber)) {
        i--;
      } else {
        randomIndexNumbers.add(randomIndexNumber);
      }
    }
    return randomIndexNumbers;
  }

  afterClickedOneCard(CustomCard clickedCard) {
    setState(() => {
          clickedCards.add(clickedCard),
          clickedCard.isImageShowed = !clickedCard.isImageShowed,
          if(clickedCards.length == 3) {
            setState(()=> {
              clickedCards[1].isImageShowed = false,

            })
          }
         /* if (clickedCards.length == 2)
            {
              if (clickedCards[0].imageName == clickedCards[1].imageName &&
                  clickedCards[0].cardIndex != clickedCards[1].cardIndex)
                {
                  score += 10,
                  clickedCards = [],
                }
              else
                {
                  clickedCards[0].isImageShowed = false,
                  clickedCards[1].isImageShowed = false,
                  clickedCards = [],
                }
            }*/
        });
  }

  generateCards(List<int> randomImageNumbers, List<int> randomIndexNumbers) {
    int imageNumberIndex = 0;
    for (int i = 0; i < getTotalCardCount; i += 2) {
      cardsOnScreen[randomIndexNumbers[i]] = CustomCard(
          cardIndex: randomIndexNumbers[i],
          imageName: '${randomImageNumbers[imageNumberIndex]}.png',
          clickedCardNameFunc: (clickedCard) =>
              afterClickedOneCard(clickedCard));
      cardsOnScreen[randomIndexNumbers[i + 1]] = CustomCard(
          cardIndex: randomIndexNumbers[i + 1],
          imageName: '${randomImageNumbers[imageNumberIndex]}.png',
          clickedCardNameFunc: (clickedCard) =>
              afterClickedOneCard(clickedCard));
      imageNumberIndex++;
    }
  }

  @override
  void initState() {
    List<int> randomImageNumbers = randomImageNumberChoose();
    List<int> randomIndexNumbers = randomIndexNumberChoose();
    generateCards(randomImageNumbers, randomIndexNumbers);
    super.initState();
  }

  get scoreText => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Score: $score',
          style: const TextStyle(fontSize: 40),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.appHeader),
      ),
      body: Center(
        child: Column(children: [
          scoreText,
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cardsOnScreen.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => cardsOnScreen[index],
          )
        ]),
      ),
    );
  }
}

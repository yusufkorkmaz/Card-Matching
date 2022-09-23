import 'dart:math';

import 'package:card_matching/custom_widgets/card.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

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
  List<List> clickedCards = [];

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

  afterClickedOneCard(String imageNameInClickedCard, int imageIndex) {
    setState(() => {
          clickedCardName = imageNameInClickedCard,
          clickedCardIndex = imageIndex,
          clickedCards.add([clickedCardName, imageIndex]),
      print(clickedCards),

      if (clickedCards.length == 2)
            {
              if (clickedCards[0][0] == clickedCards[1][0] && clickedCards[0][1] != clickedCards[1][1])
                {
                  score += 10,
                  clickedCards = [],
                }
              else
                {
                  clickedCards = [],
                }
            }
        });
  }

  generateCards(List<int> randomImageNumbers, List<int> randomIndexNumbers) {
    int imageNumberIndex = 0;
    for (int i = 0; i < getTotalCardCount; i += 2) {
      cardsOnScreen[randomIndexNumbers[i]] = CustomCard(
        cardIndex: randomIndexNumbers[i],
          imageName: '${randomImageNumbers[imageNumberIndex]}.png',
          clickedCardNameFunc: (imageName, cardIndex) => afterClickedOneCard(imageName, cardIndex));
      cardsOnScreen[randomIndexNumbers[i + 1]] = CustomCard(
        cardIndex: randomIndexNumbers[i+1],
          imageName: '${randomImageNumbers[imageNumberIndex]}.png',
          clickedCardNameFunc: (imageName, cardIndex) => afterClickedOneCard(imageName, cardIndex));
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
      style: TextStyle(fontSize: 40),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Card Matching Game'),
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

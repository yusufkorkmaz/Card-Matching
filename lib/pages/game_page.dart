import 'dart:async';
import 'dart:math';
import 'package:card_matching/custom_widgets/card.dart';
import 'package:card_matching/custom_widgets/confetti.dart';
import 'package:card_matching/custom_widgets/iconButton.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String appHeader;

  const GamePage({Key? key, required this.appHeader}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ConfettiController _controllerCenter = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  //game difficulty
  int drawStarClosingSeconds = 2;
  int cardsClosingMilliseconds = 750;

  static int get getTotalCardCount => 15;
  int totalImageCount = 30;

  bool allCardsMatch = false;
  bool gameOverCardVisible = false;

  double _turns = 0.0;
  bool _resetGameIconButtonShowing = false;
  final int _resetGameIconShowingMillisecondTime = 300;

  int score = 0;
  int clickedCardIndex = 0;
  int matchedCardCounter = 0;
  int firstClickedCardIndex = 0;
  int secondClickedCardIndex = 0;
  String firstClickedCardImageName = "";
  String secondClickedCardImageName = "";

  Random randomNumber = Random();

  List openedCard = [];
  List clickedCards = [];
  late List<int> randomImageNumbers;
  late List<int> randomIndexNumbers;
  String clickedCardName = '';
  List<Map> cardsOnScreen = List<Map>.filled(getTotalCardCount, {});

  randomImageNumberChoose() {
    List<int> randomImageNumbers = [];
    for (int i = 0; i < getTotalCardCount / 2; i++) {
      int randomImageNumber = randomNumber.nextInt(totalImageCount) + 1;
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

  clickedCardsDisable(int firstCardIndex, int secondCardIndex) {
    cardsOnScreen[firstCardIndex]['isClickable'] = false;
    cardsOnScreen[secondCardIndex]['isClickable'] = false;
  }

  clickedCardsEnable(int firstCardIndex, int secondCardIndex) {
    cardsOnScreen[firstCardIndex]['isClickable'] = true;
    cardsOnScreen[secondCardIndex]['isClickable'] = true;
  }

  clickedCardsImageHiding(int firstCardIndex, int secondCardIndex) {
    cardsOnScreen[firstCardIndex]['isImageShowing'] = false;
    cardsOnScreen[secondCardIndex]['isImageShowing'] = false;
  }

  afterClickedOneCard(CustomCard clickedCard) {
    setState(
      () => {
        clickedCards.add(clickedCard),
        clickedCardIndex = clickedCard.cardIndex,
        cardsOnScreen[clickedCardIndex]['isImageShowing'] =
            !cardsOnScreen[clickedCardIndex]['isImageShowing'],
        if (clickedCards.length == 2)
          {
            firstClickedCardIndex = clickedCards[0].cardIndex,
            secondClickedCardIndex = clickedCards[1].cardIndex,
            firstClickedCardImageName = clickedCards[0].imageName,
            secondClickedCardImageName = clickedCards[1].imageName,
            if (firstClickedCardImageName == secondClickedCardImageName &&
                firstClickedCardIndex != secondClickedCardIndex)
              {
                score += 10,
                clickedCardsDisable(
                    firstClickedCardIndex, secondClickedCardIndex),
                clickedCards = [],
                _controllerCenter.play(),
                matchedCardCounter++,
                if (matchedCardCounter == cardsOnScreen.length / 2)
                  {gameOver()}
                else
                  {
                    Timer(
                      Duration(seconds: drawStarClosingSeconds),
                      () {
                        setState(
                          () => {
                            _controllerCenter.stop(),
                          },
                        );
                      },
                    ),
                  }
              }
            else
              {
                clickedCardsDisable(
                    firstClickedCardIndex, secondClickedCardIndex),
                Timer(
                  Duration(milliseconds: cardsClosingMilliseconds),
                  () {
                    setState(
                      () => {
                        clickedCardsImageHiding(
                            firstClickedCardIndex, secondClickedCardIndex),
                        clickedCardsEnable(
                            firstClickedCardIndex, secondClickedCardIndex)
                      },
                    );
                  },
                ),
                clickedCards = [],
              }
          }
      },
    );
  }

  gameOver() {
    setState(() => {
          allCardsMatch = true,
          _resetGameIconButtonShowing = true,
        });
  }

  resetGame() {
    _changeRotation();
    setState(() {
      score = 0;
      matchedCardCounter = 0;
      _controllerCenter.stop();
      randomImageNumbers = randomImageNumberChoose();
      randomIndexNumbers = randomIndexNumberChoose();
      generateCards(randomImageNumbers, randomIndexNumbers);
      allCardsMatch = false;
      Timer(
        Duration(milliseconds: _resetGameIconShowingMillisecondTime),
        () {
          setState(
            () => {
              _turns = 0.0,
              _resetGameIconButtonShowing = false,
              _controllerCenter.stop(),
            },
          );
        },
      );
    });
  }

  generateCards(List<int> randomImageNumbers, List<int> randomIndexNumbers) {
    //same image assignment in
    // cardsOnScreen[randomIndexNumbers[i]]
    // and
    // cardsOnScreen[randomIndexNumbers[i+1]]
    // then imageIndex increase
    int imageNumberIndex = 0;
    for (int i = 0; i < getTotalCardCount; i++) {
      if (i % 2 == 0 && i != 0) {
        imageNumberIndex++;
      }
      cardsOnScreen[randomIndexNumbers[i]] = {
        "cardIndex": randomIndexNumbers[i],
        "isClickable": true,
        "isImageShowing": false,
        "imageName": '${randomImageNumbers[imageNumberIndex]}.png',
        "clickedCardNameFunc": (CustomCard clickedCard) =>
            afterClickedOneCard(clickedCard),
      };
    }
  }

  _changeRotation() {
    _turns += 2 / 3;
  }

  _getGridColumnCount() {
    if (getTotalCardCount == 4) {
      return 2;
    } else if (getTotalCardCount < 24) {
      return 3;
    } else {
      return 4;
    }
  }

  get scoreText => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Score: $score',
          style: const TextStyle(fontSize: 40),
        ),
      );

  @override
  void initState() {
    List<int> randomImageNumbers = randomImageNumberChoose();
    List<int> randomIndexNumbers = randomIndexNumberChoose();
    generateCards(randomImageNumbers, randomIndexNumbers);
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.appHeader),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Confetti(controller: _controllerCenter),
          ),
          Positioned(
            right: 0,
            child: Confetti(controller: _controllerCenter),
          ),
          Column(
            children: [
              scoreText,
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: cardsOnScreen.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getGridColumnCount(),
                  ),
                  itemBuilder: (context, index) => CustomCard(
                    cardIndex: cardsOnScreen[index]['cardIndex'],
                    imageName: cardsOnScreen[index]['imageName'],
                    isClickable: cardsOnScreen[index]['isClickable'],
                    isImageShowing: cardsOnScreen[index]['isImageShowing'],
                    clickedCardNameFunc: cardsOnScreen[index]
                        ['clickedCardNameFunc'],
                  ),
                ),
              )
            ],
          ),
          Center(
            child: AnimatedSize(
              duration: Duration(
                milliseconds: _resetGameIconShowingMillisecondTime,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              curve: Curves.easeInQuart,
              child: AnimatedRotation(
                turns: _turns,
                duration: Duration(
                  milliseconds: _resetGameIconShowingMillisecondTime,
                ),
                child: CustomIconButton(
                  onPressed: () => resetGame,
                  icon: Icons.refresh,
                  iconButtonShowing: _resetGameIconButtonShowing,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

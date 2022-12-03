import 'package:card_matching/pages/game_page.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';

class GameStartPage extends StatelessWidget {
  GameStartPage({Key? key}) : super(key: key);

  final List levels = [
    {'text': 'Level 1', 'totalCardCount': 4},
    {'text': 'Level 2', 'totalCardCount': 6},
    {'text': 'Level 3', 'totalCardCount': 12},
    {'text': 'Level 4', 'totalCardCount': 20},
    {'text': 'Level 5', 'totalCardCount': 24},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: levels.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Flat3dButton.text(
              color: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              text: levels[index]['text'],
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                        appHeader: 'Animal Matching Game',
                        totalCardCount: levels[index]['totalCardCount']),
                  ),
                )
              },
            ),
          ),
        ),
      ),
    );
  }
}

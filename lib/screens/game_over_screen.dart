import 'package:flutter/material.dart';
import 'package:office_quote_game/models/quote.dart';

import 'game_screen.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key, required this.score, required this.quote})
      : super(key: key);
  final int score;
  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Unlucky!\n\nThe correct answer was\n${quote.character}\n\nYou scored $score",
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text("PLAY AGAIN"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

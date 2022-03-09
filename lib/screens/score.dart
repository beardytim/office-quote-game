import 'package:flutter/material.dart';

import 'game.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key, required this.score}) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: 600,
              color: Colors.blueAccent,
              child: Center(child: Text("You scored $score")),
            ),
            Expanded(
              child: Center(
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
            ),
          ],
        ),
      ),
    );
  }
}

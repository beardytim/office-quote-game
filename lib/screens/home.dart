import 'package:flutter/material.dart';

import 'game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              child: const Center(child: Text('WELCOME!')),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  child: const Text("START"),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_quote_game/models/quote.dart';

import 'game_screen.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen(
      {Key? key,
      required this.score,
      required this.quote,
      required this.player})
      : super(key: key);
  final int score;
  final String player;
  final Quote quote;

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  void initState() {
    logScore();

    super.initState();
  }

  void logScore() async {
    //UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    String user = FirebaseAuth.instance.currentUser!.uid;

    int score = await FirebaseFirestore.instance
        .collection('highscores')
        .doc(user)
        .get()
        .then((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data['score'];
    });

    await FirebaseFirestore.instance.collection('highscores').doc(user).set({
      'score': score < widget.score ? widget.score : score,
      'name': widget.player
    });
  }

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
                "Unlucky ${widget.player}!\n\nThe correct answer was\n${widget.quote.character}.\n\nYou scored ${widget.score}.",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            const HighScores(),
            Center(
              child: ElevatedButton(
                child: const SizedBox(
                  height: 60,
                  width: 90,
                  child: Center(child: Text("PLAY AGAIN")),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(player: widget.player)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighScores extends StatelessWidget {
  const HighScores({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'High Scores',
          style: Theme.of(context).textTheme.headline5,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('highscores')
                .orderBy('score', descending: true)
                .limit(3)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }
              return Center(
                child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Text("${data['name']} - ${data['score']}");
                  }).toList(),
                ),
              );
            }),
      ],
    );
  }
}

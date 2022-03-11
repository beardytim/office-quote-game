import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    loadName();
    super.initState();
  }

  void loadName() async {
    //UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    String user = FirebaseAuth.instance.currentUser!.uid;
    String name = await FirebaseFirestore.instance
        .collection('highscores')
        .doc(user)
        .get()
        .then((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data['name'];
    });
    if (name.isNotEmpty) {
      controller.text = name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'How well do you think you know The Office?\n\nSee how you score!',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const SizedBox(
                  height: 60,
                  width: 90,
                  child: Center(child: Text("START")),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (controller.text.isEmpty) {
                      controller.text = "Anonymous";
                    }
                    //basic filter to hide rude people
                    String clean = ProfanityFilter().censor(controller.text);
                    return GameScreen(player: clean);
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

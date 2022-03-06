import 'package:flutter/material.dart';
import '/utils/quote_fetcher.dart';
import '/models/quote.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;
  QuoteFetcher quoteService = QuoteFetcher();
  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = quoteService.fetchQuote();
  }

  void _incrementScore() {
    setState(() {
      _score++;
      futureQuote = quoteService.fetchQuote();
    });
  }

  void _endGame() {
    setState(() {
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Quote>(
          future: futureQuote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Quote quote = snapshot.data!;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          quote.quote,
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  buttonBar(quote),
                  Text(
                    '$_score',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Column buttonBar(Quote quote) {
    List<String> nameList = [
      "Michael Scott",
      "Jim Halpert",
      "Dwight Schrute",
      "Pam Beesly",
      "Ryan Howard",
      "Kelly Kapoor",
      "Angela Martin",
      "Kevin Malone",
      "Oscar Martinez",
      "Andy Bernard",
      "Stanley Hudson",
      "Phyllis Lapin",
      "Toby Flenderson",
      "Erin Hannon",
      "Gabe Lewis",
      "Darryl Philbin",
      "Creed Bratton",
      "Jo Bennett",
      "Holly Flax",
      "Jan Levinson",
      "Todd Packer",
      "Charles Minor",
      "Deangelo Vickers",
      "Josh Porter",
      "Ed Truck",
      "Hunter null",
      "David Wallace"
    ];
    //need to remove the answer from the list of names then randomise names, then make new list with 3 of them and add the answer name to that list....
    List<String> names = [];
    names.addAll(nameList);
    names.remove(quote.character);
    names.shuffle();
    names.removeRange(3, names.length);
    names.add(quote.character);
    names.shuffle();
    return Column(
      children: [
        for (String name in names) button(name, quote),
      ],
    );
  }

  Padding button(String name, Quote quote) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () {
          if (name == quote.character) {
            _incrementScore();
          } else {
            _endGame();
          }
        },
        child: SizedBox(
          height: 30,
          width: 150,
          child: Center(
              child: name == "Hunter null" ? const Text('Hunter') : Text(name)),
        ),
      ),
    );
  }
}

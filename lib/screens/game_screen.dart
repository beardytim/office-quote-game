import 'package:flutter/material.dart';
import 'package:office_quote_game/screens/game_over_screen.dart';
import '../utils/name_service.dart';
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

  void _endGame(Quote quote) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GameOverScreen(score: _score, quote: quote)),
    );
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
                  // Text(
                  //   '$_score',
                  //   style: Theme.of(context).textTheme.headline4,
                  // ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Column buttonBar(Quote quote) {
    List<String> names = NameService().fetchNames(quote.character);
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
            _endGame(quote);
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

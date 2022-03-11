import 'package:flutter/material.dart';
import 'package:office_quote_game/screens/game_over_screen.dart';
import '../utils/name_service.dart';
import '/utils/quote_fetcher.dart';
import '/models/quote.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.player}) : super(key: key);
  final String player;

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
        builder: (context) => GameOverScreen(
          score: _score,
          quote: quote,
          player: widget.player,
        ),
      ),
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          quote.quote,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 10.0,
                  ),
                  buttonBar(quote),
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

  Widget buttonBar(Quote quote) {
    List<String> names = NameService().fetchNames(quote.character);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(names[0], quote),
            const SizedBox(width: 10),
            button(names[1], quote),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(names[2], quote),
            const SizedBox(width: 10),
            button(names[3], quote),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget button(String name, Quote quote) {
    return OutlinedButton(
      onPressed: () {
        if (name == quote.character) {
          _incrementScore();
        } else {
          _endGame(quote);
        }
      },
      child: SizedBox(
        height: 50,
        width: 100,
        child: Center(
            child: name == "Hunter null"
                ? const Text('Hunter')
                : Text(
                    name,
                    textAlign: TextAlign.center,
                  )),
      ),
    );
  }
}

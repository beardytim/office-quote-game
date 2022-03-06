import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Quote Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _score = 0;
  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  void _incrementScore() {
    setState(() {
      _score++;
      futureQuote = fetchQuote();
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

Future<Quote> fetchQuote() async {
  final response = await http.get(
    Uri.parse("https://www.officeapi.dev/api/quotes/random"),
  );

  if (response.statusCode == 200) {
    //200 = OK
    return Quote.fromJson(jsonDecode(response.body));
  } else {
    //Not a 200 from server so thrown exception.
    throw Exception("Failed to get quote");
  }
}

class Quote {
  final String id;
  final String quote;
  final String characterId;
  final String character;

  Quote({
    required this.id,
    required this.quote,
    required this.characterId,
    required this.character,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['data']['_id'],
      quote: json['data']['content'],
      characterId: json['data']['character']['_id'],
      character: json['data']['character']['firstname'] +
          " " +
          json['data']['character']['lastname'],
    );
  }
}

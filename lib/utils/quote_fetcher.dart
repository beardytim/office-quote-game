import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/quote.dart';

class QuoteFetcher {
  Future<Quote> fetchQuote() async {
    final response = await http.get(
      Uri.parse("https://www.officeapi.dev/api/quotes/random"),
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      //200 = OK
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      //Not a 200 from server so thrown exception.
      throw Exception("Failed to get quote");
    }
  }
}

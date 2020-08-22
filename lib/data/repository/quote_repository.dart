import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class QuoteRepository {
  Future<List> getQuotes(int page);
}

class QuoteRepositoryImpl implements QuoteRepository {
  @override
  Future<List> getQuotes(int page) async {
    var response = await http
        .get("https://programming-quotes-api.herokuapp.com/quotes/page/$page");

    var data = json.decode(response.body);
    return data;
  }
}

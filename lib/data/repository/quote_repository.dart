import 'dart:convert';

import 'package:quotes/data/model/quote_model.dart';
import 'package:http/http.dart' as http;
import 'package:quotes/res/strings.dart';

abstract class QuoteRepository {
  Future<List> getQuotes();
}

class QuoteRepositoryImpl implements QuoteRepository {
  @override
  Future<List> getQuotes() async {
    var response = await http.get(AppStrings.url);

    var data = json.decode(response.body);
    return data;
  }
}

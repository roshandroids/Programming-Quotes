import 'package:flutter/material.dart';

class QuoteDetails extends StatefulWidget {
  final String author;
  final String en;
  final double rating;
  QuoteDetails(
      {@required this.author, @required this.en, @required this.rating});
  @override
  _QuoteDetailsState createState() => _QuoteDetailsState();
}

class _QuoteDetailsState extends State<QuoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.author),
            Text(widget.en),
            Text(widget.rating.toString())
          ],
        ),
      ),
    );
  }
}

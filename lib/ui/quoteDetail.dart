import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.en,
                  style: GoogleFonts.lato(fontSize: 20),
                ),
              ),
              Text(
                "- " + widget.author,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RatingBarIndicator(
                  itemPadding: EdgeInsets.all(5),
                  rating: widget.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

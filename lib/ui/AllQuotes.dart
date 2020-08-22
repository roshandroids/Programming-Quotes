import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/bloc/quote_bloc.dart';
import 'package:quotes/data/model/quote_model.dart';
import 'package:quotes/di.dart';
import 'package:quotes/ui/quoteDetail.dart';

class AllQuotes extends StatefulWidget {
  @override
  _AllQuotesState createState() => _AllQuotesState();
}

class _AllQuotesState extends State<AllQuotes> {
  QuoteBloc quoteBloc = sl<QuoteBloc>();
  int page = 1;
  @override
  void initState() {
    super.initState();
    getQuotes(page);
  }

  void getQuotes(int page) async {
    quoteBloc.add(FetchQuoteEvent(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          "Programming Quotes",
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select a Page",
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Page:" + page.toString(),
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 25,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, item) {
                    return InkWell(
                      splashColor: Colors.green,
                      onTap: () {
                        setState(() {
                          page = item + 1;
                        });
                        print(item + 1);
                        getQuotes(item + 1);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color.fromRGBO(0, 0, 0, 0.5))
                          ],
                        ),
                        child: Text(
                          (item + 1).toString(),
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: BlocListener<QuoteBloc, QuoteState>(
                bloc: this.quoteBloc,
                listener: (context, state) {
                  if (state is QuoteErrorState) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                },
                child: BlocBuilder<QuoteBloc, QuoteState>(
                    bloc: this.quoteBloc,
                    builder: (context, state) {
                      if (state is QuoteInitialState) {
                        return buildLoading();
                      } else if (state is QuoteLoadingState) {
                        return buildLoading();
                      } else if (state is QuoteLoadedState) {
                        return loadArticles(state.quotes);
                      } else if (state is QuoteErrorState) {
                        return showError(state.message);
                      } else {
                        return Container(
                          child: Center(
                            child: Text("No data"),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Loading Quotes...",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget showError(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget loadArticles(List<QuoteModel> quoteList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: quoteList.length,
        itemBuilder: (context, item) {
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuoteDetails(
                            author: quoteList[item].author,
                            en: quoteList[item].en,
                            rating: quoteList[item].rating,
                          )),
                );
              },
              title: Text(quoteList[item].en),
              subtitle: Text(quoteList[item].author),
            ),
          );
        });
  }
}

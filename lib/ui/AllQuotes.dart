import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes/bloc/quote_bloc.dart';
import 'package:quotes/data/model/quote_model.dart';
import 'package:quotes/data/repository/quote_repository.dart';
import 'package:quotes/di.dart';
import 'package:quotes/ui/quoteDetail.dart';

class AllQuotes extends StatefulWidget {
  @override
  _AllQuotesState createState() => _AllQuotesState();
}

class _AllQuotesState extends State<AllQuotes> {
  QuoteBloc quoteBloc = sl<QuoteBloc>();
  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  void getQuotes() async {
    quoteBloc.add(FetchQuoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programming Quotes"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => quoteBloc.add(FetchQuoteEvent()))
        ],
      ),
      body: Container(
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
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showError(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget loadArticles(List<QuoteModel> quoteList) {
    return ListView.builder(
        itemCount: quoteList.length,
        itemBuilder: (context, item) {
          return ListTile(
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
            title: Text(quoteList[item].author),
            subtitle: Text(quoteList[item].rating.toString()),
          );
        });
  }
}

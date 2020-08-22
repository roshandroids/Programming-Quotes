import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quotes/data/model/quote_model.dart';
import 'package:quotes/data/repository/quote_repository.dart';
part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<FetchQuoteEvent, QuoteState> {
  QuoteRepository repository;
  QuoteBloc({@required this.repository});

  @override
  QuoteState get initialState => QuoteInitialState();

  @override
  Stream<QuoteState> mapEventToState(
    FetchQuoteEvent event,
  ) async* {
    if (event is FetchQuoteEvent) {
      yield QuoteLoadingState();
      try {
        List data = await repository.getQuotes(event.page);
        List<QuoteModel> quotes =
            data.map((e) => QuoteModel.fromJson(e)).toList();
        yield QuoteLoadedState(quotes: quotes);
      } catch (e) {
        yield QuoteErrorState(
          message: e.toString(),
        );
      }
    }
  }
}

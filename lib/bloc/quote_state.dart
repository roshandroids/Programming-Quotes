part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {}

class QuoteInitialState extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoadingState extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoadedState extends QuoteState {
  final List<QuoteModel> quotes;

  QuoteLoadedState({@required this.quotes});

  @override
  List<Object> get props => [quotes];
}

class QuoteErrorState extends QuoteState {
  final String message;
  QuoteErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}

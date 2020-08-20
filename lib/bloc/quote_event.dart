part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {}

class FetchQuoteEvent extends QuoteEvent {
  @override
  List<Object> get props => [];
}

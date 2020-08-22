part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {}

class FetchQuoteEvent extends QuoteEvent {
  final int page;
  FetchQuoteEvent({@required this.page});
  @override
  List<Object> get props => [page];
}

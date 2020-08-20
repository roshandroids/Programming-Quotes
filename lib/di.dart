import 'package:get_it/get_it.dart';
import 'package:quotes/bloc/quote_bloc.dart';
import 'package:quotes/data/repository/quote_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  _blocRegister();
}

void _blocRegister() {
  sl.registerFactory(() => QuoteBloc(repository: sl()));
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl());
}

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movee_app/core/network/network_info.dart';
import 'package:movee_app/features/get_Movies/data/dataSource/get_movies_datasource.dart';
import 'package:movee_app/features/get_Movies/data/repository/get_movies_repository_impl.dart';
import 'package:movee_app/features/get_Movies/domain/repository/get_movies_repository.dart';
import 'package:movee_app/features/get_Movies/domain/usecases/get_movies_usecase.dart';
import 'package:movee_app/features/get_Movies/presentation/bloc/bloc/movies_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  general();
  injectFeed();
}

void general() {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void injectFeed() {
  sl.registerLazySingleton<GetMoviesDataSource>(
      () => GetMoviesDataSourceImpl());
  sl.registerLazySingleton<GetMoviesRepository>(
      () => GetMoviesRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetMoviesUsecase(repository: sl()));

  sl.registerLazySingleton<MoviesBloc>(
      () => MoviesBloc(getMoviesUsecase: sl()));
}

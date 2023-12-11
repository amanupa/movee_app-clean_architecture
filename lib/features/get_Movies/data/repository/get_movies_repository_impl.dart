import 'package:dartz/dartz.dart';
import 'package:movee_app/core/error/failure.dart';
import 'package:movee_app/features/get_Movies/data/dataSource/get_movies_datasource.dart';
import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';
import 'package:movee_app/features/get_Movies/domain/repository/get_movies_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class GetMoviesRepositoryImpl extends GetMoviesRepository {
  final GetMoviesDataSource dataSource;
  final NetworkInfo networkInfo;

  GetMoviesRepositoryImpl(
      {required this.dataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<GetMoviesModelClass>>> getMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getMovies();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}

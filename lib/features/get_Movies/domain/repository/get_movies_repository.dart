import 'package:dartz/dartz.dart';
import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';

import '../../../../core/error/failure.dart';

abstract class GetMoviesRepository {
  Future<Either<Failure, List<GetMoviesModelClass>>> getMovies();
}

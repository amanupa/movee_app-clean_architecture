import 'package:dartz/dartz.dart';
import 'package:movee_app/core/constant/usecase/usecase_interface.dart';
import 'package:movee_app/core/error/failure.dart';
import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';
import 'package:movee_app/features/get_Movies/domain/repository/get_movies_repository.dart';

class GetMoviesUsecase extends UseCase<List<GetMoviesModelClass>, NoParams> {
  final GetMoviesRepository repository;

  GetMoviesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<GetMoviesModelClass>>> call(NoParams entity) {
    return repository.getMovies();
  }
}

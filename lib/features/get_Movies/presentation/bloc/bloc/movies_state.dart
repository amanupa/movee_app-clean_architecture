part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {
  const MoviesState();

  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

class MoviesLodedState extends MoviesState {
  final List<GetMoviesModelClass> moviesList;

  const MoviesLodedState({required this.moviesList});
  @override
  List<Object> get props => [moviesList];
}

class MoviesDetailState extends MoviesState {
  final int index;

  final List<GetMoviesModelClass> getMoviesModelClass;

  const MoviesDetailState({required this.getMoviesModelClass,required this.index});
}

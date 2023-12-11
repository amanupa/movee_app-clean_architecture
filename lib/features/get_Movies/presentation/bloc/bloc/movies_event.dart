// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class MovieLodedEvent extends MoviesEvent {
  MovieLodedEvent();
}

class MovieDetailsEvent extends MoviesEvent {
  final int index;

  MovieDetailsEvent(
    this.index,
  );
}

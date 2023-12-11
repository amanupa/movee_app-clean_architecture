// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:movee_app/core/constant/usecase/usecase_interface.dart';

import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';
import 'package:movee_app/features/get_Movies/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUsecase getMoviesUsecase;
  MoviesBloc({
    required this.getMoviesUsecase,
  }) : super(MoviesInitial()) {
    on<MovieLodedEvent>((event, emit) async {
      const CircularProgressIndicator();
      final result = await getMoviesUsecase(NoParams());
      result.fold((failure) {
        const CircularProgressIndicator();
      }, (loaded) {
        print("the data in  the bloc");
        print(loaded);
        emit(MoviesLodedState(moviesList: loaded));
      });
    });
    on<MovieDetailsEvent>((event, emit) async {
      final result = await getMoviesUsecase(NoParams());
      result.fold((failure) => const CircularProgressIndicator(), (loaded) {
        emit(MoviesDetailState(getMoviesModelClass: loaded, index:  event.index));
      });
    });
  }
}

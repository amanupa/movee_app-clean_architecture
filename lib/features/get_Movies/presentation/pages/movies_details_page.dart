// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movee_app/core/constant/app_colors.dart';
import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';
import 'package:movee_app/features/get_Movies/presentation/bloc/bloc/movies_bloc.dart';

import '../../../../core/constant/injection.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int index;
  final List<GetMoviesModelClass> movies;

  const MovieDetailsScreen({
    Key? key,
    required this.index,
    required this.movies,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _block = sl<MoviesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.movies[widget.index].show.name),
      ),
      body: BlocProvider(
        create: (context) => _block,
        child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, State) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 13),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 500,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.yellow, width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget
                                  .movies[widget.index].show.image!.original))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.elliptical(10, 10)),
                            border:
                                Border.all(color: AppColors.primary, width: 2)),
                        child: Text(widget.movies[widget.index].show.summary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Container(
                          height: 150,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(10, 10)),
                              border: Border.all(
                                  color: AppColors.primary, width: 2)),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: const Icon(Icons.link),
                                  title: Text(widget.movies[widget.index].show
                                      .links!.self.href),
                                  subtitle: const Text("self"),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.link),
                                title: Text(widget.movies[widget.index].show
                                    .links!.previousepisode!.href),
                                subtitle: const Text("Previous Episode"),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movee_app/core/constant/app_colors.dart';
import 'package:movee_app/core/constant/app_textstyle_constant.dart';
import 'package:movee_app/core/constant/injection.dart';
import 'package:movee_app/features/get_Movies/data/models/get_movies_model.dart';
import 'package:movee_app/features/get_Movies/presentation/bloc/bloc/movies_bloc.dart';
import 'package:movee_app/features/get_Movies/presentation/pages/movies_details_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GetMoviesModelClass> _moviesList = [];
  late List<GetMoviesModelClass> _movee;
  int pageIndex = 0;
  final _block = sl<MoviesBloc>();
  @override
  void initState() {
    _block.add(MovieLodedEvent());
    super.initState();
  }

  @override
  void dispose() {
    _block.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.search,
                color: AppColors.black,
              ),
            )
          ],
          backgroundColor: AppColors.primary,
          title: const Text(
            "Fan Flix",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          )),
      body: BlocProvider(
        create: (context) => _block,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              BlocListener<MoviesBloc, MoviesState>(listener: (context, State) {
            if (State is MoviesLodedState) {
              _moviesList = State.moviesList;
            }
            if (State is MoviesDetailState) {
              _movee = State.getMoviesModelClass;
              pageIndex = State.index;
              print(pageIndex);
              print(_block.state);

              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return MovieDetailsScreen(
                  index: pageIndex,
                  movies: _movee,
                );
              }));
            }
          }, child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              return _buildBody();
            },
          )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.chat,
          color: AppColors.primary,
          size: 40,
        ),
        backgroundColor: AppColors.black,
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/splashScreenImage.jpg",
                  ))),
        ),
        ListView.builder(
            itemCount: _moviesList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!_block.isClosed) {
                    _block.add(MovieDetailsEvent(index));
                  }

                  // Navigate here
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MovieDetailsScreen(
                      index: index,
                      movies: _moviesList,
                    );
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 2, color: AppColors.black)),
                    child: Column(
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      _moviesList[index].show.image!.original),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ), //Image.network(_moviesList[index].show.image)
                  ),
                ),
              );
            }),
      ],
    );
  }
}

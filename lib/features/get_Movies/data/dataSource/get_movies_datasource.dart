import 'dart:convert';

import 'package:movee_app/core/constant/api_url_constant.dart';

import '../../../../core/api/custom_http_client.dart';
import '../../../../core/error/exception.dart';
import '../models/get_movies_model.dart';

abstract class GetMoviesDataSource {
  Future<List<GetMoviesModelClass>> getMovies();
}

class GetMoviesDataSourceImpl extends GetMoviesDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();
  @override
  Future<List<GetMoviesModelClass>> getMovies() async {
    List<GetMoviesModelClass> moviesList = [];
    final response = await customHttpClient.get(Uri.parse(getMoviesUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("the data in the datasource");
      print(data);
      for (int i = 0; i < data.length; i++) {
        print("the data in the datasource in the loop");
        print(data[i]);
        moviesList.add(GetMoviesModelClass.fromJson(data[i]));
      }

      return moviesList;
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }
}

import 'package:uts_2072001/data/data_movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  List<Movie> movies = await Movie.fetchMovie('avenge');
  // print(movies[1].title);
  for (Movie m in movies) {
    print('Title: ${m.title}');
    print('Actors: ${m.actors}');
    print('Posters: ${m.posters}');
    print('');
  }
}

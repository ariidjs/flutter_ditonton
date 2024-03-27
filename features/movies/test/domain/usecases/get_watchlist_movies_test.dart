import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/movie_test_helper.mocks.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';


void main() {
  late GetWatchlistMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieList));
  });
}

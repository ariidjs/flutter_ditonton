import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/movie_test_helper.mocks.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';



void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListStatus(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}

import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(repository: mockTvRepository);
  });

  test('should remove watchlist from the repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlistTv(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
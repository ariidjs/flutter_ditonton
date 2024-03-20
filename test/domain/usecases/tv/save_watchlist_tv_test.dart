import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/tv_dummy_object.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlistTv(repository: mockTvRepository);
  });

  test('should save move to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlistTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}

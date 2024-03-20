import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTvShows(repository: mockTvRepository);
  });

  final tTv = <TvShow>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTvShows())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}

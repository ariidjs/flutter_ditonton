import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetOnTheAirTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnTheAirTvShows(repository: mockTvRepository);
  });

  final tTv = <TvShow>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getOnTheAirTvShows())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}

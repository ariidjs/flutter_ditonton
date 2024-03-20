import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvShowRecommendations(repository: mockTvRepository);
  });

  final tId = 1;
  final tTv = <TvShow>[];

  test(
    "should get list of tv recommendaions from the repository",
    () async {
      // arange
      when(mockTvRepository.getTvShowRecommendations(tId))
          .thenAnswer((_) async => Right(tTv));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(tTv));
    },
  );
}
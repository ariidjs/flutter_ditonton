import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';
import 'package:tvshow/domain/entities/tv_show.dart';


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

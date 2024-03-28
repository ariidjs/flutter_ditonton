import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';



void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonDetail(repository: mockTvRepository);
  });

  final tvId = 1;
  final seasonNumber = 2;

  group('GetTvSeasonDetail Tests', () {
    test(
        'should get detail season tv shows the repository when execute function is called',
        () async {
      // arrange
      when(mockTvRepository.getSeasonDetail(tvId, seasonNumber))
          .thenAnswer((_) async => Right(testTvSeasonDetail));
      // act
      final result = await usecase.execute(tvId, seasonNumber);
      // assert
      expect(result, Right(testTvSeasonDetail));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/tv_test_helper.mocks.dart';
import '../../../dummy_data/tv/tv_dummy_object.dart';


void main() {
  late GetTvShowDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvShowDetail(repository: mockTvRepository);
  });

  final tId = 1;

  test(
    "should get tv detail from the repository",
    () async {
      // arrange
      when(mockTvRepository.getTvShowDetail(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(testTvDetail));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/tv_test_helper.mocks.dart';
import '../../../dummy_data/tv/tv_dummy_object.dart';


void main() {
  late GetWatchlistTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvShows(repository: mockTvRepository);
  });

  test(
    "should get list of tv from the repository",
    () async {
      // arrange
      when(mockTvRepository.getWatchlistTvShows())
          .thenAnswer((_) async => Right(testTvList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvList));
    },
  );
}

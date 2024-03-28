import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';
import 'package:tvshow/domain/entities/tv_show.dart';


void main() {
  late GetPopularTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvShows(repository: mockTvRepository);
  });

  final tTv = <TvShow>[];

  group('getPopularTv tests', () {
    group('excute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTvShows())
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}

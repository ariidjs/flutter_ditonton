import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';
import 'package:tvshow/domain/entities/tv_show.dart';



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

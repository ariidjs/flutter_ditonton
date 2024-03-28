import 'package:dartz/dartz.dart';
import 'package:tvshow/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/tv_test_helper.mocks.dart';
import 'package:tvshow/domain/entities/tv_show.dart';


void main() {
  late SearchTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvShows(repository: mockTvRepository);
  });

  final tTv = <TvShow>[];
  final tQuery = 'chainsaw man';

  test('should get lst of tv from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}

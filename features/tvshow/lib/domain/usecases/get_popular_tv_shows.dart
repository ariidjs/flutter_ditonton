import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularTvShows {
  final TvRepository repository;

  GetPopularTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShows();
  }
}
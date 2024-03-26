import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

class GetPopularTvShows {
  final TvRepository repository;

  GetPopularTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShows();
  }
}

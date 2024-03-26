import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

class GetTopRatedTvShows {
  final TvRepository repository;

  GetTopRatedTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShows();
  }
}

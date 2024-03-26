import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvShows {
  final TvRepository repository;

  GetTopRatedTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShows();
  }
}

import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import '../repositories/tv_repository.dart';
import 'package:tvshow/domain/entities/tv_show.dart';


class GetOnTheAirTvShows {
  final TvRepository repository;

  GetOnTheAirTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnTheAirTvShows();
  }
}

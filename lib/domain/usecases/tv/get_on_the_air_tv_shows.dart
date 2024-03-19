import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetOnTheAirTvShows {
  final TvRepository repository;

  GetOnTheAirTvShows({required this.repository});

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnTheAirTvShows();
  }
}

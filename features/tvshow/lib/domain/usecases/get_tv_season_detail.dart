import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/season_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail({required this.repository});

  Future<Either<Failure, SeasonDetail>> execute(int tvId, int seasonNumber) {
    return repository.getSeasonDetail(tvId, seasonNumber);
  }
}

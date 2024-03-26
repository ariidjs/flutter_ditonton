import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import '../repositories/tv_repository.dart';
import 'package:tvshow/domain/entities/season_detail.dart';


class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail({required this.repository});

  Future<Either<Failure, SeasonDetail>> execute(int tvId, int seasonNumber) {
    return repository.getSeasonDetail(tvId, seasonNumber);
  }
}

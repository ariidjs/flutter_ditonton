import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import '../repositories/tv_repository.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';


class GetTvShowDetail {
  final TvRepository repository;

  GetTvShowDetail({required this.repository});

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}

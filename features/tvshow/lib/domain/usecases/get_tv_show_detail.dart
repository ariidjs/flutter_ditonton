import 'package:core/common/failure.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv_detail.dart';

class GetTvShowDetail {
  final TvRepository repository;

  GetTvShowDetail({required this.repository});

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}

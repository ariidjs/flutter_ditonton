import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv({required this.repository});

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}

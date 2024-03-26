import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv({required this.repository});

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}

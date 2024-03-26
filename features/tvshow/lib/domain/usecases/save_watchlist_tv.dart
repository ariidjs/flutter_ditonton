import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import '../repositories/tv_repository.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';


class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv({required this.repository});

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}

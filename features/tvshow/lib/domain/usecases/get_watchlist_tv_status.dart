import '../repositories/tv_repository.dart';

class GetWatchlistTvStatus {
  final TvRepository repository;

  GetWatchlistTvStatus({required this.repository});

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}

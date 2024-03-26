import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import 'package:flutter/material.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetOnTheAirTvShows getOnTheAirTvShows;
  OnTheAirTvNotifier(
    this.getOnTheAirTvShows,
  );

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _onTheAirTv = [];
  List<TvShow> get tv => _onTheAirTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _onTheAirTv = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

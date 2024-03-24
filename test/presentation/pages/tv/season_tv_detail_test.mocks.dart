// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/presentation/pages/tv/season_tv_detail_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:ui' as _i14;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv/season_detail.dart' as _i7;
import 'package:ditonton/domain/entities/tv/tv_detail.dart' as _i13;
import 'package:ditonton/domain/entities/tv/tv_show.dart' as _i10;
import 'package:ditonton/domain/usecases/tv/get_tv_season_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_tv_show_recommendations.dart'
    as _i3;
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_status.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart' as _i6;
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart' as _i5;
import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvSeasonDetail_0 extends _i1.SmartFake
    implements _i2.GetTvSeasonDetail {
  _FakeGetTvSeasonDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTvShowRecommendations_1 extends _i1.SmartFake
    implements _i3.GetTvShowRecommendations {
  _FakeGetTvShowRecommendations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchlistTvStatus_2 extends _i1.SmartFake
    implements _i4.GetWatchlistTvStatus {
  _FakeGetWatchlistTvStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlistTv_3 extends _i1.SmartFake
    implements _i5.SaveWatchlistTv {
  _FakeSaveWatchlistTv_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlistTv_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTv {
  _FakeRemoveWatchlistTv_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSeasonDetail_5 extends _i1.SmartFake implements _i7.SeasonDetail {
  _FakeSeasonDetail_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvSeasonDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeasonDetailNotifier extends _i1.Mock
    implements _i8.TvSeasonDetailNotifier {
  MockTvSeasonDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvSeasonDetail get getTvSeasonDetail => (super.noSuchMethod(
        Invocation.getter(#getTvSeasonDetail),
        returnValue: _FakeGetTvSeasonDetail_0(
          this,
          Invocation.getter(#getTvSeasonDetail),
        ),
      ) as _i2.GetTvSeasonDetail);

  @override
  _i3.GetTvShowRecommendations get getTvShowRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getTvShowRecommendations),
        returnValue: _FakeGetTvShowRecommendations_1(
          this,
          Invocation.getter(#getTvShowRecommendations),
        ),
      ) as _i3.GetTvShowRecommendations);

  @override
  _i4.GetWatchlistTvStatus get getWatchlistTvStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchlistTvStatus),
        returnValue: _FakeGetWatchlistTvStatus_2(
          this,
          Invocation.getter(#getWatchlistTvStatus),
        ),
      ) as _i4.GetWatchlistTvStatus);

  @override
  _i5.SaveWatchlistTv get saveWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#saveWatchlistTv),
        returnValue: _FakeSaveWatchlistTv_3(
          this,
          Invocation.getter(#saveWatchlistTv),
        ),
      ) as _i5.SaveWatchlistTv);

  @override
  _i6.RemoveWatchlistTv get removeWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#removeWatchlistTv),
        returnValue: _FakeRemoveWatchlistTv_4(
          this,
          Invocation.getter(#removeWatchlistTv),
        ),
      ) as _i6.RemoveWatchlistTv);

  @override
  _i7.SeasonDetail get seasonDetail => (super.noSuchMethod(
        Invocation.getter(#seasonDetail),
        returnValue: _FakeSeasonDetail_5(
          this,
          Invocation.getter(#seasonDetail),
        ),
      ) as _i7.SeasonDetail);

  @override
  _i9.RequestState get seasonState => (super.noSuchMethod(
        Invocation.getter(#seasonState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);

  @override
  List<_i10.TvShow> get tvRecommendations => (super.noSuchMethod(
        Invocation.getter(#tvRecommendations),
        returnValue: <_i10.TvShow>[],
      ) as List<_i10.TvShow>);

  @override
  _i9.RequestState get recommendationState => (super.noSuchMethod(
        Invocation.getter(#recommendationState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  String get watchlistMessage => (super.noSuchMethod(
        Invocation.getter(#watchlistMessage),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.getter(#watchlistMessage),
        ),
      ) as String);

  @override
  bool get isAddedToWatchlist => (super.noSuchMethod(
        Invocation.getter(#isAddedToWatchlist),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i12.Future<void> fetchSeasonDetail(
    int? tvId,
    int? seasonNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSeasonDetail,
          [
            tvId,
            seasonNumber,
          ],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
        Invocation.method(
          #loadWatchlistStatus,
          [id],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> addWatchlist(_i13.TvDetail? tv) => (super.noSuchMethod(
        Invocation.method(
          #addWatchlist,
          [tv],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> removeFromWatchlist(_i13.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [tv],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  void addListener(_i14.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i14.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

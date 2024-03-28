import 'package:core/core.dart';
import 'package:tvshow/tvshow.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tvshow/data/datasources/tv_local_data_source.dart';
import 'package:tvshow/data/datasources/tv_remote_data_source.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/movies/dummy_objects.dart';

void main() {
  final _movie = testMovie;
  testWidgets(
      'When create widget '
      'Should find the correct widgets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: MovieCard(_movie),
        ),
      ),
    );

    await tester.pump();

    expect(find.text(_movie.title!), findsOneWidget);
  });
}

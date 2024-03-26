import '../../../features/tvshow/lib/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';

void main() {
  final _tvShow = testTv;
  testWidgets(
      'When create widget '
      'Should find the correct widgets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: TvCard(_tvShow),
        ),
      ),
    );

    await tester.pump();

    expect(find.text(_tvShow.name!), findsOneWidget);
  });
}

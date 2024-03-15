import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/ontheair_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_onththeair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_series_ontheair_page_test.mocks.dart';

@GenerateMocks([TVSeriesOnTheAirNotifier])
void main() {
  late MockTVSeriesOnTheAirNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTVSeriesOnTheAirNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVSeriesOnTheAirNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Unit test for tv series on thea air list page testing...', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.movies).thenReturn(<Movie>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

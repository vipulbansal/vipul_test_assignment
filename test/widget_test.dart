import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vipul_test_assignment/blocs/countries_bloc/countries_bloc.dart';
import 'package:vipul_test_assignment/presentation/screens/home_screen.dart';
import 'package:vipul_test_assignment/presentation/widgets/spinner_with_title.dart';


class MockCountriesBloc extends MockBloc<CountriesEvent, CountriesState> implements CountriesBloc {
  @override
  // Provide a non-null default state
  CountriesState get state => super.state;
}

void main() async{
  group('HomeScreen Tests', () {
    late MockCountriesBloc mockCountriesBloc;

    setUp(() {
      mockCountriesBloc = MockCountriesBloc();

      whenListen(
          mockCountriesBloc,
          Stream.fromIterable([
            CountriesState(
              countriesData: [], // Mock data
              statesData: [], // Mock data
              isLoading: false,
              isFailure: false,
              errorMessage: '',
            )
          ]),
          initialState: CountriesState(
            countriesData: [], // Mock data
            statesData: [], // Mock data
            isLoading: false,
            isFailure: false,
            errorMessage: '',
          )
      );
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<CountriesBloc>(
          create: (_) => mockCountriesBloc,
          child: const HomeScreen(),
        ),
      );
    }

    testWidgets('ensures two CustomSpinner widgets are present', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final customSpinnerFinder = find.byType(CustomSpinner);
      expect(customSpinnerFinder, findsNWidgets(2));
    });
  });
}

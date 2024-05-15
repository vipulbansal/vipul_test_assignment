import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vipul_test_assignment/blocs/countries_bloc/countries_bloc.dart';
import 'package:vipul_test_assignment/commons/helpers/show_dialogs.dart';
import 'package:vipul_test_assignment/presentation/widgets/spinner_with_title.dart';

import '../../services/loading_spinner_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CountriesBloc, CountriesState>(
        listener: (context, countriesState) {
          if (countriesState.isLoading) {
            LoadingSpinnerService.loadingStream.add(true);
          } else if (countriesState.isFailure) {
            LoadingSpinnerService.loadingStream.add(false);
            showSnack(context, message: countriesState.errorMessage);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomSpinner(
                      allItems: state.countriesData,
                      onChanged: (val) {
                        context
                            .read<CountriesBloc>()
                            .add(CountrySelected(val.id));
                      },
                      topTitle: 'Select Country',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomSpinner(
                      allItems: state.statesData,
                      onChanged: (_) {},
                      topTitle: 'Select State',
                      initialSelected: null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleapi/home/bloc/home_bloc.dart';
import 'package:sampleapi/services/boredService.dart';
import 'package:sampleapi/services/connectivityService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.activityName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(state.activityType),
                  Text(
                    state.participants.toString(),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const Text('LOAD NEXT'),
                  )
                ],
              );
            }
            if (state is HomeNoInternetState) {
              return const Text('no internet :(');
            }
            return Container();
          },
        ),
      ),
    );
  }
}

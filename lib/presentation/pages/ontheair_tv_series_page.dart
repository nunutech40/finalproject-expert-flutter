import 'package:ditonton/presentation/bloc/ontheair_tv_series/ontheair_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OnTheAirTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/ontheair-tvseries';

  @override
  _OnTheAirTVSeriesPageState createState() => _OnTheAirTVSeriesPageState();
}

class _OnTheAirTVSeriesPageState extends State<OnTheAirTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OntheairTvSeriesBloc>().add(OntheairTvSeriesDidLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OntheairTvSeriesBloc, OntheairTvSeriesState>(
          builder: (context, state) {
            if (state is OntheairTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OntheairTvSeriesHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(movies[index], false);
                },
                itemCount: movies.length,
              );
            } else if (state is OntheairTvSeriesError) {
              return Center(
                key: Key('error_message_server'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message_default'),
                child: Text("I'm Sory to hear that, that the app is error"),
              );
            }
          },
        ),
      ),
    );
  }
}

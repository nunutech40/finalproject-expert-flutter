import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvSeriesBloc>().add(PopularTvSeriesDidLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(movies[index], false);
                },
                itemCount: movies.length,
              );
            } else if (state is PopularTvSeriesError) {
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

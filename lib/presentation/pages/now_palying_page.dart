import 'package:ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-page';

  @override
  _NowPlayingPage createState() => _NowPlayingPage();
}

class _NowPlayingPage extends State<NowPlayingPage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingMovieBloc>().add(NowPlayingDidLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
          builder: (context, state) {
            if (state is NowPlayingMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingMovieHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(movies[index], false);
                },
                itemCount: movies.length,
              );
            } else if (state is NowPlayingMovieError) {
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

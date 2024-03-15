import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/now_playing_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<NowPlayingMoviesNotifier>(context, listen: false)
            .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie, false);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}

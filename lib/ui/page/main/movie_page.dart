import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/movie_bloc.dart';
import 'package:media_app/router/route.dart';
import 'package:mx_core/mx_core.dart';

@ARoute(url: Pages.movie)
class MoviePage extends StatefulWidget {
  final RouteOption option;

  MoviePage(this.option): super();

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MovieBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: false,
        title: "",
        child: Container(),
      ),
    );
  }
}
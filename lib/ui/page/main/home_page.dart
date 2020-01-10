import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/main/home_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.home)
class HomePage extends StatefulWidget {
  final RouteOption option;

  HomePage(this.option): super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);
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
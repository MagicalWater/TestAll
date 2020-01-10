import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/ex_home/ex_sub_home_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.exSubHome)
class ExSubHomePage extends StatefulWidget {
  final RouteOption option;

  ExSubHomePage(this.option): super();

  @override
  _ExSubHomePageState createState() => _ExSubHomePageState();
}

class _ExSubHomePageState extends State<ExSubHomePage> {
  ExSubHomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExSubHomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        title: "ExSubHome",
        child: Container(),
      ),
    );
  }
}
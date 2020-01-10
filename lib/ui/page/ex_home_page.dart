import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/ex_home_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.exHome)
class ExHomePage extends StatefulWidget {
  final RouteOption option;

  ExHomePage(this.option): super();

  @override
  _ExHomePageState createState() => _ExHomePageState();
}

class _ExHomePageState extends State<ExHomePage> {
  ExHomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExHomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        title: "ExHome",
        child: Container(),
      ),
    );
  }
}
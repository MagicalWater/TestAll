import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/ex_launch_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.exLaunch)
class ExLaunchPage extends StatefulWidget {
  final RouteOption option;

  ExLaunchPage(this.option): super();

  @override
  _ExLaunchPageState createState() => _ExLaunchPageState();
}

class _ExLaunchPageState extends State<ExLaunchPage> {
  ExLaunchBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExLaunchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        title: "ExLaunch",
        child: Container(),
      ),
    );
  }
}
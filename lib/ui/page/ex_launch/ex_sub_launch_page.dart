import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/ex_launch/ex_sub_launch_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.exSubLaunch)
class ExSubLaunchPage extends StatefulWidget {
  final RouteOption option;

  ExSubLaunchPage(this.option): super();

  @override
  _ExSubLaunchPageState createState() => _ExSubLaunchPageState();
}

class _ExSubLaunchPageState extends State<ExSubLaunchPage> {
  ExSubLaunchBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExSubLaunchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        title: "ExSubLaunch",
        child: Container(),
      ),
    );
  }
}
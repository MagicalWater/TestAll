import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/ex_home/ex_sub_home/ex_sub_sub_home_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.exSubSubHome)
class ExSubSubHomePage extends StatefulWidget {
  final RouteOption option;

  ExSubSubHomePage(this.option): super();

  @override
  _ExSubSubHomePageState createState() => _ExSubSubHomePageState();
}

class _ExSubSubHomePageState extends State<ExSubSubHomePage> {
  ExSubSubHomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExSubSubHomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        title: "ExSubSubHome",
        child: Container(),
      ),
    );
  }
}
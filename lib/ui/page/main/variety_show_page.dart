import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/main/variety_show_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.varietyShow)
class VarietyShowPage extends StatefulWidget {
  final RouteOption option;

  VarietyShowPage(this.option): super();

  @override
  _VarietyShowPageState createState() => _VarietyShowPageState();
}

class _VarietyShowPageState extends State<VarietyShowPage> {
  VarietyShowBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<VarietyShowBloc>(context);
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
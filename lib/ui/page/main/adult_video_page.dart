import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/adult_video_bloc.dart';
import 'package:media_app/router/route.dart';
import 'package:mx_core/mx_core.dart';

@ARoute(url: Pages.adultVideo)
class AdultVideoPage extends StatefulWidget {
  final RouteOption option;

  AdultVideoPage(this.option): super();

  @override
  _AdultVideoPageState createState() => _AdultVideoPageState();
}

class _AdultVideoPageState extends State<AdultVideoPage> {
  AdultVideoBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AdultVideoBloc>(context);
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
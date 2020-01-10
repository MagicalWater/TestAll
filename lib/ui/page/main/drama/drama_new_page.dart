import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/drama/drama_new_bloc.dart';
import 'package:media_app/router/route.dart';
import 'package:mx_core/mx_core.dart';

@ARoute(url: Pages.dramaNew)
class DramaNewPage extends StatefulWidget {
  final RouteOption option;

  DramaNewPage(this.option): super();

  @override
  _DramaNewPageState createState() => _DramaNewPageState();
}

class _DramaNewPageState extends State<DramaNewPage> {
  DramaNewBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DramaNewBloc>(context);
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
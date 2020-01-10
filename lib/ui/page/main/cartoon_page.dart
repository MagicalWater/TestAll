import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/bloc/page/main/cartoon_bloc.dart';
import 'package:media_app/bloc/application_bloc.dart';

@ARoute(url: Pages.cartoon)
class CartoonPage extends StatefulWidget {
  final RouteOption option;

  CartoonPage(this.option): super();

  @override
  _CartoonPageState createState() => _CartoonPageState();
}

class _CartoonPageState extends State<CartoonPage> {
  CartoonBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CartoonBloc>(context);
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
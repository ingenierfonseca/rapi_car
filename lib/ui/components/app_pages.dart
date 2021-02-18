import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/components/no_app_bar.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:provider/provider.dart';

class AppPages extends StatefulWidget {
  final Function onWillPop;
  final Widget drawer;
  final CupertinoNavigationBar appBar;
  final Widget body;
  final dynamic arguments;
  final bool isPesosFacil;

  AppPages({
    this.onWillPop,
    this.drawer,
    this.appBar,
    @required this.body,
    this.arguments,
    this.isPesosFacil = false,
  });

  @override
  _AppPagesState createState() => _AppPagesState();
}

class _AppPagesState extends State<AppPages> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppPageManager>(
      create: (_) => AppPageManager(
        initialPage: widget.body,
        arguments: widget.arguments,
      ),
      builder: (context, child) {
        var manager = context.watch<AppPageManager>();

        return WillPopScope(
          onWillPop: () async {
            var result = !context.pop();
            if (result) result = await widget.onWillPop();
            return result;
          },
          child: Scaffold(
            appBar: widget.appBar ?? NoAppBar(),
            drawer: widget.drawer ?? Container(),
            body: Scaffold(
              appBar: manager.appBar,
              body: manager.lastPage,
            ),
          ),
        );
      },
    );
  }
}
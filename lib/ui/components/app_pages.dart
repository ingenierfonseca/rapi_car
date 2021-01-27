import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:pagobiccos/core/models/db/account.dart';
//import 'package:pagobiccos/src/pages/components/bottom_nav_bar_item_page.dart';
import 'package:rapi_car_app/ui/components/no_app_bar.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
//import 'package:pagobiccos/ui/res/colors.dart';
import 'package:provider/provider.dart';
//import 'package:pagobiccos/ui/util/screen_util.dart';

class AppPages extends StatefulWidget {
  final Function onWillPop;
  final Widget drawer;
  final CupertinoNavigationBar appBar;
  final Widget body;
  final dynamic arguments;
  //final List<BottomNavBarItemPage> bottomNavItemsPage;
  final bool isPesosFacil;

  AppPages({
    this.onWillPop,
    this.drawer,
    this.appBar,
    @required this.body,
    this.arguments,
    //this.bottomNavItemsPage,
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
            /*bottomNavigationBar: Visibility(
              visible: true,
              child: Visibility(
                visible: manager.showBottomNav,
                child: BottomNavigationBar(
                  backgroundColor: context.select((Account a) => a.pesosMode)
                      ? kBottomNavColorPesos
                      : kBottomNavColor,
                  selectedItemColor: (manager.currentBottomNavItem >= 0)
                      ? Colors.white
                      : Colors.white70,
                  unselectedItemColor: Colors.white70,
                  selectedFontSize: (manager.currentBottomNavItem >= 0)
                      ? 14.0.sf()
                      : 12.0.sf(),
                  unselectedFontSize: 12.0.sf(),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: (manager.currentBottomNavItem > 0)
                      ? manager.currentBottomNavItem
                      : 0,
                  onTap: (index) => context.pushReplacement(
                      page: widget.bottomNavItemsPage[index].page,
                      menuItemId: index),
                  items:
                      widget.bottomNavItemsPage.map((ip) => ip.item).toList(),
                ),
              ),
            ),*/
          ),
        );
      },
    );
  }
}
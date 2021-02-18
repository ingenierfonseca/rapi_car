import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/components/app_bar.dart';
import 'package:rapi_car_app/ui/viewmodels/view_model.dart';
import 'package:rapi_car_app/ui/components/no_app_bar.dart';
//import 'package:pagobiccos/src/pages/providers/biccos_pages/components_page/appbar_page.dart';
import 'package:rapi_car_app/ui/components/app_page.dart';
//import 'package:pagobiccos/src/pages/providers/biccos_pages/components_page/bottom_nav_page.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/ui/viewmodels/viewmodel_page.dart';

class AppPageManager extends ChangeNotifier {
  ViewModel _viewModel;
  Widget _appBar = NoAppBar();
  List<AppPage> _pagesList = [];
  bool _showBottomNav = true;
  int _currentBottomNavItem = 0;

  AppPageManager({
    Widget initialPage,
    dynamic arguments,
  }) {
    _pagesList.add(AppPage(
      page: initialPage,
      arguments: arguments,
    ));
  }

  ViewModel get viewModel => _viewModel;

  Widget get appBar => _appBar;

  Widget get lastPage => _pagesList.last.page;

  dynamic get getArguments => _pagesList.last.arguments;

  bool get showBottomNav => _showBottomNav;

  int get currentBottomNavItem => _currentBottomNavItem;

  void _disposePage() {
    _viewModel?.disposeViewModel();
    _viewModel = null;
  }

  bool push({@required Widget page, dynamic arguments, String id}) {
    _addingComponetsPage(page);
    _pagesList.add(AppPage(page: page, arguments: arguments, id: id));
    notifyListeners();
    return true;
  }

  bool pushAndClear(
      {@required Widget page, dynamic arguments, int menuItemId}) {
    _disposePage();
    _currentBottomNavItem = menuItemId;
    _addingComponetsPage(page);
    _pagesList.clear();
    _pagesList.add(AppPage(page: page, arguments: arguments));
    notifyListeners();
    return true;
  }

  void popPush({@required Widget page, dynamic arguments, String id}) {
    pop(id: id, notify: false);
    push(page: page, arguments: arguments, id: id);
  }

  bool pop({String id, bool notify = true}) {
    var isNotLast = _pagesList.length > 1;
    if (isNotLast) {
      if (id != null) {
        var index = _pagesList.indexWhere((p) => p.id == id);
        if (index > 0) {
          _pagesList.removeRange(index + 1, _pagesList.length);
        }
      } else {
        _pagesList.removeLast();
      }

      var page = _pagesList.last.page;
      _addingComponetsPage(page);
      if (notify) notifyListeners();
    }
    return isNotLast;
  }

  void createRoute({@required List<AppPage> pagesList}) {
    _disposePage();
    _pagesList = pagesList;
    var page = _pagesList.last.page;
    _addingComponetsPage(page);
    notifyListeners();
  }

  void _addingComponetsPage(Widget page) {
    if (page is AppBarPage) _appBar = (page as AppBarPage).getAppBar();
    //_showBottomNav = (page is BottomNavPage);
    if (page is ViewModelPage) {
      _viewModel = (page as ViewModelPage).getViewModel();
    }
  }
}

extension BiccosPageExtesion on BuildContext {
  void push({@required Widget page, dynamic arguments, String id}) =>
      read<AppPageManager>().push(page: page, arguments: arguments, id: id);

  void pushPostCall({@required Widget page, dynamic arguments, String id}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      read<AppPageManager>().push(page: page, arguments: arguments, id: id);
    });
  }

  void pushReplacement(
          {@required Widget page, dynamic arguments, int menuItemId = -1}) =>
      read<AppPageManager>().pushAndClear(
          page: page, arguments: arguments, menuItemId: menuItemId);

  void pushReplacementPostCall(
      {@required Widget page, dynamic arguments, int menuItemId = -1}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      read<AppPageManager>().pushAndClear(
          page: page, arguments: arguments, menuItemId: menuItemId);
    });
  }

  void popPush({@required Widget page, dynamic arguments, String id}) =>
      read<AppPageManager>()
          .popPush(page: page, arguments: arguments, id: id);

  void popPushPostCall({@required Widget page, dynamic arguments, String id}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      read<AppPageManager>()
          .popPush(page: page, arguments: arguments, id: id);
    });
  }

  bool pop({String id}) => read<AppPageManager>().pop(id: id);

  void createRoute({@required List<AppPage> route}) =>
      read<AppPageManager>().createRoute(pagesList: route);

  dynamic getArguments() => read<AppPageManager>().getArguments;

  T getViewModel<T extends ViewModel>() => read<AppPageManager>().viewModel;

  void dispose() => read<AppPageManager>()._disposePage();

  void openDrawer() => Scaffold.of(this).openDrawer();
}
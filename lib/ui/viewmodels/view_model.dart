import 'package:flutter/foundation.dart';
import 'package:rapi_car_app/core/utils/result.dart';

abstract class ViewModel extends ChangeNotifier {
  var _result = Result();

  Result get result => _result;
  ViewModel() {
    setViewModelToRepository();
  }

  void setViewModelToRepository();

  void setState({Result result}) {
    _result = result;
    notifyListeners();
  }

  void resetStateResult() {
    _result.state = null;
  }

  void disposeViewModel() {}

  @override
  void dispose() {
    super.dispose();
  }
}
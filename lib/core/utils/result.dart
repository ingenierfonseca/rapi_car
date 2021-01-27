import 'package:rapi_car_app/core/utils/state_enum.dart';

class Result {
  ViewState state;
  dynamic data;
  dynamic ex;
  Result({
    this.state,
    this.data,
    this.ex,
  });

  static Result loading() => Result(state: ViewState.LOADING);

  static Result complete({dynamic data}) =>
      Result(state: ViewState.COMPLETE, data: data);

  static Result error<Data>({dynamic ex}) =>
      Result(state: ViewState.ERROR, ex: ex);

  bool get isLoadig => state == ViewState.LOADING;
  bool get isComplete => state == ViewState.COMPLETE;
}
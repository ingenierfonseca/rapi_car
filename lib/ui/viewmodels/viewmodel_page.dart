import 'package:rapi_car_app/di/locator.dart';

mixin ViewModelPage<T> {
  final T _viewModel = locator<T>();
  T getViewModel() => _viewModel;
}
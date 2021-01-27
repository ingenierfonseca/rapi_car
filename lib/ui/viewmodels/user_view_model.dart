import 'package:rapi_car_app/core/utils/result.dart';
import 'package:rapi_car_app/core/utils/state_enum.dart';
import 'package:rapi_car_app/ui/viewmodels/view_model.dart';
import 'package:rapi_car_app/di/locator.dart';
import 'package:rapi_car_app/core/services/user_service.dart';

class UserViewModel extends ViewModel {
  final _userService = locator<UserService>();

  //final _accountService = locator<AccountService>();

  @override
  void setState({Result result}) async {
    if (result.state == ViewState.COMPLETE /*&& result.data is User*/) {
      //_userService.addUserStream(user: result.data);
    }
    super.setState(result: result);
  }

  void fetchUser() async {
    //await _userService.userRepo.fetchUser();
  }

  void _doRequest(Future<void> request) async {
    setState(result: Result.loading());
    try {
      await request;
    } catch (e) {
      setState(result: Result.error(ex: e));
    }
  }

  void logout() {
    _userService.logout();
    //_accountService.pesosMode(false);
    //_accountService.valid(false);
  }

  @override
  void setViewModelToRepository() {
    //_userService.userRepo.viewModel = this;
  }
}
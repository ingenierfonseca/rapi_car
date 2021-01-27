import 'package:rapi_car_app/src/models/payment_model.dart';
import 'package:rapi_car_app/ui/viewmodels/view_model.dart';

class PaymentViewModel extends ViewModel {

  PaymentModel selectedPayment;

  @override
  void setViewModelToRepository() {
    //_servicesPayRepository.viewModel = this;
  }
}
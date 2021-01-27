import 'package:rapi_car_app/core/utils/result.dart';
import 'package:rapi_car_app/src/models/car_model.dart';
import 'package:rapi_car_app/ui/viewmodels/view_model.dart';
import 'package:rapi_car_app/di/locator.dart';

class CarViewModel extends ViewModel {
  //final _servicesPayRepository = locator<ServicesPayRepository>();
  //final _walletService = locator<WalletService>();

  CarModel selectedCar;
  //Service selectedService;
  //Product selectedProduct;

  //var paymentServiceRequest = PaymentServiceRequest();

  void getCategories() {
    //_doRequest(_servicesPayRepository.fetchCategories());
  }

  void getServices() {
    //_doRequest(
        //_servicesPayRepository.fetchServices(category: selectedCategory));
  }

  void searchServices(String service) {
    //_doRequest(_servicesPayRepository.searchServices(service: service));
  }

  void getProducts() async {
    //_doRequest(
      //_servicesPayRepository.fetchProducts(
        //service: selectedService,
      //),
    //);
  }

  void getCommissions() {
    //_doRequest(_servicesPayRepository.getCommissions(
        //paymentServiceRequest: paymentServiceRequest));
  }

  void payServiceProduct({bool payWithcard = false}) {
    //_doRequest(_servicesPayRepository.payServiceProduct(
        //paymentServiceRequest: paymentServiceRequest,
        //payWithCard: payWithcard));
  }

  void _doRequest(Future<void> request) async {
    setState(result: Result.loading());
    try {
      await request;
    } catch (e) {
      setState(result: Result.error(ex: e));
    }
  }

  /*List<Wallet> wallets(bool pesosMode) {
    return (pesosMode)
        ? _walletService.wallets.values.where((w) => w.useInPesosFacil).toList()
        : _walletService.wallets.values
            .where((w) => !w.useInPesosFacil)
            .toList();
  }*/

  @override
  void setViewModelToRepository() {
    //_servicesPayRepository.viewModel = this;
  }
}
import '../data/order_data.dart';
import '../data/order_data_mock.dart';

enum Flavor { mock, real }

class Injector {
  Injector._internal();
  static final _singleton = Injector._internal();
  static const Flavor _flavor = Flavor.mock;
  
  factory Injector() {
    return _singleton;
  }
  
  OrderRepository get orderRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockOrderRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockOrderRepository();
    }
  }
}
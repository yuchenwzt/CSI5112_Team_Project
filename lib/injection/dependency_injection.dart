import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/user_data_mock.dart';

import '../data/item_data.dart';
import '../data/item_data_mock.dart';

import 'package:csi5112_project/data/merchant_data.dart';
import 'package:csi5112_project/data/merchant_data_mock.dart';

import '../data/order_data.dart';
import '../data/order_data_mock.dart';

import 'package:csi5112_project/data/item_data_mock_cart.dart';

enum Flavor { mock, real }

class Injector {
  Injector._internal();
  static final _singleton = Injector._internal();
  static const Flavor _flavor = Flavor.mock;

  factory Injector() {
    return _singleton;
  }

  ItemRepository get itemRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockItemRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockItemRepository();
    }
  }

  UserRepository get userRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockUserRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockUserRepository();
    }
  }

  MerchantRepository get merchantRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockMerchantRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockMerchantRepository();
    }
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

  ItemRepository get itemCartRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockItemCartRepositoryCart();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockItemCartRepositoryCart();
    }
  }
}

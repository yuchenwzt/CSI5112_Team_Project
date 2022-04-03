import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/data/customer_data.dart';
import 'package:csi5112_project/data/anser_data.dart';
import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/data/merchant_data.dart';
import 'package:csi5112_project/data/order_data.dart';
import 'package:csi5112_project/data/product_data.dart';
import 'package:csi5112_project/data/question.dart';
import 'package:csi5112_project/data/shipping_address_data.dart';
import 'package:csi5112_project/data/filter_option_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/service/cart_product_http.dart';

import 'package:csi5112_project/service/product_http.dart';
import 'package:csi5112_project/service/filter_option.dart';
import 'package:csi5112_project/service/answer_http.dart';
import 'package:csi5112_project/service/cart_item_http.dart';
import 'package:csi5112_project/service/customer_http.dart';
import 'package:csi5112_project/service/merchant_http.dart';
import 'package:csi5112_project/service/order_http.dart';
import 'package:csi5112_project/service/question_http.dart';
import 'package:csi5112_project/service/shipping_address_http.dart';
import 'package:csi5112_project/service/user_http.dart';

enum Flavor { mock, real }

class Injector {
  Injector._internal();
  static final _singleton = Injector._internal();
  static const Flavor _flavor = Flavor.real;

  factory Injector() {
    return _singleton;
  }

  ProductRepository get productRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockItemRepository();
      case Flavor.real:
        return RealProductRepository();
      default:
        return RealProductRepository();
    }
  }

  FilterOptionRepository get filterOptionRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockItemRepository();
      case Flavor.real:
        return RealFilterOptionRepository();
      default:
        return RealFilterOptionRepository();
    }
  }

  AnswerRepository get answerRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockItemRepository();
      case Flavor.real:
        return RealAnswerRepository();
      default:
        return RealAnswerRepository();
    }
  }

  CustomerRepository get customerRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockUserRepository();
      case Flavor.real:
        return RealCustomerRepository();
      default:
        return RealCustomerRepository();
    }
  }

  MerchantRepository get merchantRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockMerchantRepository();
      case Flavor.real:
        return RealMerchantRepository();
      default:
        return RealMerchantRepository();
    }
  }

  OrderRepository get orderRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockOrderRepository();
      case Flavor.real:
        return RealOrderRepository();
      default:
        return RealOrderRepository();
    }
  }

  CartItemRepository get cartItemRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockCartItemRepository();
      case Flavor.real:
        return RealCartItemRepository();
      default:
        return RealCartItemRepository();
    }
  }

  CartProductRepository get cartProductRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockCartItemRepository();
      case Flavor.real:
        return RealCartProductRepository();
      default:
        return RealCartProductRepository();
    }
  }

  QuestionRepository get questionRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockCartItemRepository();
      case Flavor.real:
        return RealQuestionRepository();
      default:
        return RealQuestionRepository();
    }
  }

  UserRepository get userRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockCartItemRepository();
      case Flavor.real:
        return RealUserRepository();
      default:
        return RealUserRepository();
    }
  }

  ShippingAddressRepository get shippingAddressRepository {
    switch (_flavor) {
      // case Flavor.mock:
      //   return MockCartItemRepository();
      case Flavor.real:
        return RealShippingAddressRepository();
      default:
        return RealShippingAddressRepository();
    }
  }
}

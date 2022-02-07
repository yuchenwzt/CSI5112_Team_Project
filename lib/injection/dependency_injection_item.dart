import '../data/item_data.dart';
import '../data/item_data_mock.dart';

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
}
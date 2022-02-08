import 'dart:async';
import 'item_data.dart';

class MockItemRepository implements ItemRepository {
  @override
  Future<List<Item>> fetch() => Future.value(kContacts);
}

var kContacts = <Item>[
  Item(
    id: '1234',
    name: 'Alienware',
    type: 'Computer',
    price: "1000",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Dell Computer",
    location: 'LA',
    chat: [],
  ),
  Item(
    id: '2234',
    name: 'Macbook',
    type: 'Computer',
    price: "2000",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Apple Computer",
    location: 'NYU',
    chat: [],
  ),
  Item(
    id: '3234',
    name: 'Iphone',
    type: 'Phone',
    price: "300",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Apple Phone",
    location: 'LA',
    chat: [],
  ),
  Item(
    id: '4234',
    name: 'Galaxy S22',
    type: 'Phone',
    price: "400",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Samsung Computer",
    location: 'WU',
    chat: [],
  ),
  Item(
    id: '5234',
    name: 'Red',
    type: 'Camera',
    price: "4000",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Camera",
    location: 'FL',
    chat: [],
  ),
  Item(
    id: '6234',
    name: 'Blue',
    type: 'Camera',
    price: "4500",
    orderId: "0",
    date: "2022.01.01",
    image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Camera",
    location: 'NYU',
    chat: [],
  ),
];
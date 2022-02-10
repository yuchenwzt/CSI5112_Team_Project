import 'dart:async';
import 'user_data.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<List<User>> fetch() => Future.value(userList);
}

const userList = <User>[
  User(
      id: '1',
      name: 'Edward',
      password: '123456',
      is_merchant: false,
      phonenumber: '(1)6132471055',
      address: '800 King Edward Ave, Ottawa, ON K1N 6N5, Canada',
      cart: [],
      history: [
        [
          'Edward',
          '2',
          '1234',
          'Alienware',
          'Computer',
          '1000',
          '0',
          '02/09/2022',
          '',
          'A Great Dell Computer'
        ],
        //customername: "Edward",  item num: "2", item Id: "1234"
        //item type: "Computer", item price: "1000", orderId: "0", date: "02/09/2022",
        //image: "", description: "A Great Dell Computer"
        [
          'Edward',
          '2',
          '2234',
          'MacBook',
          'Computer',
          '2000',
          '1',
          '02/10/2022',
          '',
          'A Great Apple Computer'
        ]
      ]),
];

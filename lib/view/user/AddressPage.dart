import 'package:flutter/material.dart';
import '../../data/user_data.dart';
import '../../module/user_presenter.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: AddressList(),
    );
  }
}

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList>
    implements UserListViewContract {
  late UserListPresenter _presenter;
  User _user = new User();
  bool isSearching = false;

  _AddressListState() {
    _presenter = UserListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    _presenter.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isSearching) {
      widget = const Center(
          child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: CircularProgressIndicator(),
      ));
    } else {
      String name = _user.name;
      String address = _user.address;
      String phonenumber = _user.phonenumber;

      widget = ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        // children: _buildUserList());
        children: <Widget>[
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Colors.blue,
              fontSize: 20.0,
              height: 1.2,
              fontFamily: "Courier",
            ),
          ),
          Text(
            phonenumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Colors.blue,
              fontSize: 20,
              height: 1.2,
              fontFamily: "Courier",
            ),
          ),
          Text(
            address,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Colors.blue,
              fontSize: 20.0,
              height: 1.2,
              fontFamily: "Courier",
            ),
          ),
        ],
      );
    }

    return widget;
  }

  @override
  void onLoadUsersComplete(List<User> users) {
    setState(() {
      _user = users[0];
      isSearching = false;
    });
  }

  @override
  void onLoadUsersError() {}

  // List<_UserListItem> _buildUserList() {
  //   return _users.map((User) => new _UserListItem(User)).toList();
  // }
}

// class _UserListItem extends ListTile {
//   _UserListItem(User user)
//       : super(
//             title: Text(user.name),
//             subtitle: Text(user.address),
//             contentPadding: Text(user.phonenumber));
// }


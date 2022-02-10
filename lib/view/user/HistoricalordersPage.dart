import 'package:flutter/material.dart';
import '../../UserPage.dart';
import '../../data/user_data.dart';
import '../../module/user_presenter.dart';
import 'InvoicePage.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: OrdersList(),
    );
  }
}

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList>
    implements UserListViewContract {
  late UserListPresenter _presenter;
  User _user = new User();

  bool isSearching = false;

  _OrdersListState() {
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
      widget = ListView.separated(
        itemCount: _user.history.length,
        itemBuilder: (BuildContext context, int index) {
          List cur_invoice = _user.history[index];
          String item_name = _user.history[index][3];
          String date = _user.history[index][7];
          String image = _user.history[index][8];
          return ListTile(
              onTap: () async {
                //导航到新路由
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return InvoicePage(
                      invoice: cur_invoice,
                    );
                  }),
                );
              },
              title: Text(item_name),
              subtitle: Text("Ordered on " + date),
              trailing: Text("Invoice >"),
              leading: new CircleAvatar(
                child: Text("Image"),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
            thickness: .1,
          );
        },
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
}

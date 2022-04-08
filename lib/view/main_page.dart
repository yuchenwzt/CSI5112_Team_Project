import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_item_page.dart';
import 'package:flutter/material.dart';
import 'product_page/product_page.dart';
import 'order_page/order_page.dart';
import 'user_page/user_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  bool isReload = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const List<Widget> titleOptions = <Widget>[
    Text(
      'Items Market',
      style: optionStyle,
    ),
    Text(
      'Shopping Cart',
      style: optionStyle,
    ),
    Text(
      'Track Orders',
      style: optionStyle,
    ),
    Text(
      'User Home',
      style: optionStyle,
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      isReload = index == 1 || index == 2 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      ProductPage(user: widget.user),
      CartPage1(user: widget.user),
      OrderPage(user: widget.user),
      UserPage(user: widget.user)
    ];
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            child: Center(child: titleOptions.elementAt(selectedIndex))),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
      ),
      // Use Tab Navigator to make sure all the route changes are inside the BottomBar Component.
      body: IndexedStack(
        index: selectedIndex,
        children: <Widget>[
          TabNavigator(index: 0, pages: pages),
          Provider.value(
            value: isReload,
            updateShouldNotify: (oldValue, newValue) => true,
            child: TabNavigator(index: 1, pages: pages),
          ),
          Provider.value(
            value: isReload,
            updateShouldNotify: (oldValue, newValue) => true,
            child: TabNavigator(index: 2, pages: pages),
          ),
          TabNavigator(index: 3, pages: pages),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'User',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key? key, required this.index, required this.pages})
      : super(key: key);

  final int index;
  final List pages;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settins) {
        late WidgetBuilder builder;
        switch (settins.name) {
          case '/':
            builder = (context) => pages[index];
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}

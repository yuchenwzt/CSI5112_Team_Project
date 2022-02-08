import 'package:flutter/material.dart';
import 'view/item/ItemPage.dart';
import 'CartPage.dart';
import 'UserPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  int selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const List<Widget> titleOptions = <Widget>[
    Text(
      'Items',
      style: optionStyle, 
    ),
    Text(
      'Chart',
      style: optionStyle,
    ),
    Text(
      'User',
      style: optionStyle,
    ),
  ];

  static const List pages = [
    ItemPage(),
    CartPage(),
    UserPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(child: Center(child: titleOptions.elementAt(selectedIndex))),
        backgroundColor: Colors.red,
      ),
      // Use Tab Navigator to make sure all the route changes are inside the BottomBar Component. 
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          TabNavigator(index: 0, pages: pages),
          TabNavigator(index: 1, pages: pages),
          TabNavigator(index: 2, pages: pages),
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
  const TabNavigator({ Key? key, required this.index, required this.pages }) : super(key: key);

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
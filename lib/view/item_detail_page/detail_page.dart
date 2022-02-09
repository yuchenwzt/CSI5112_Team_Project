import 'package:flutter/material.dart';
import 'product_description.dart';
import 'product_img.dart';
import '../../data/item_data.dart';
import '../payment_success_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.type + " Store")),
      body: ListView(children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        ProductImg(item: item),
        ProductDescription(item: item),
        const Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'place the order',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PaymentPage();
                      }),
                    );
                  },
                ),
              ),
            )),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          width: 30,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Material(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              elevation: 6,
              child: MaterialButton(
                child: const Text(
                  'Add to chart',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Text("Customer Reviews",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
            )),
        const Padding(padding: EdgeInsets.only(top: 10)),
        const Text("Top Reviews from Canada",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 6, 189, 143),
              fontSize: 20,
            )),
        const Padding(padding: EdgeInsets.only(top: 20)),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            ListTile(
                leading: Icon(Icons.person),
                title: Text("Jack posted on 01/02/2021",
                    style: TextStyle(fontSize: 12)),
                subtitle: Text("Is this laptop suitable for students?",
                    style: TextStyle(fontSize: 20, color: Colors.black))),
            ListTile(
                leading: Icon(Icons.person),
                title: Text("Tom posted on 03/02/2021",
                    style: TextStyle(fontSize: 12)),
                subtitle: Text("I use it in university, I think it's good",
                    style: TextStyle(fontSize: 20, color: Colors.black))),
            ListTile(
                leading: Icon(Icons.person),
                title: Text("Alice posted on 05/02/2021",
                    style: TextStyle(fontSize: 12)),
                subtitle: Text("My son is satisfied with it",
                    style: TextStyle(fontSize: 20, color: Colors.black))),
          ],
        ),
        SizedBox(
            width: 30,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Create Your Review',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            )),
      ]),
    );
  }
}

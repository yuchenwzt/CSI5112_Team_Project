import 'package:flutter/material.dart';
import 'HistoricalordersPage.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({
    Key? key,
    required this.invoice, // 接收一个text参数
  }) : super(key: key);
  final List invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
      ),
      body: ListView.separated(
        itemCount: invoice.length,
        itemBuilder: (context, index) {
          List<String> list = [
            'Customer Name:',
            'Quantity:',
            'Product Id:',
            'Product Name:',
            'Type:',
            'Price:',
            'Order Id:',
            'Date:',
            'Image:',
            'Description:',
          ];

          return ListTile(
            title: Text(list[index]),
            trailing: Text(
              invoice[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
            thickness: .1,
          );
        },
      ),
    );
  }
}

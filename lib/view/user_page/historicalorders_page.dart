import 'package:flutter/material.dart';
import 'invoice_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key, required this.user}) : super(key: key);

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: ListView.separated(
        itemCount: user.history.length,
        itemBuilder: (BuildContext context, int index) {
          List curInvoice = user.history[index];
          String itemName = user.history[index][3];
          String date = user.history[index][7];
          String image = user.history[index][8];
          return ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return InvoicePage(
                      invoice: curInvoice,
                    );
                  }),
                );
              },
              title: Text(itemName),
              subtitle: Text("Ordered on " + date),
              trailing: const Text("Invoice >"),
              leading: CircleAvatar(
                child: Text("Image" + image),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
            thickness: .1,
          );
        },
      ),
    );
  }
}

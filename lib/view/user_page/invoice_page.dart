import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InvoicePageState();

  const InvoicePage({
    Key? key,
    required this.invoice, // 接收一个text参数
  }) : super(key: key);
  final List invoice;
}

class InvoicePageState extends State<InvoicePage> {
  var doc = pw.Document();

  int indexOf(List<String> s, String target) {
    int i = 0;
    s.forEach((element) {
      if (s[i] == target) return;
      else i++;
    });
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        flexibleSpace: TextButton(onPressed: () => 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(title: const Text("Invoice PDF")),
                body: PdfPreview(build: (format) => doc.save(),
              ),
              );
            }),
          )
        , child: const Text("Print Invoice")),
      ),
      body: ListView.separated(
        itemCount: widget.invoice.length,
        itemBuilder: (context, index) {
          List<String> list = [
            'Order Id:',
            'Customer Id:',
            'Product Id:',
            'Product Name:',
            'Quantity:',
            'Merchant Id:',
            'Purchase Date:',
            'Total Price After Tax:'
          ];

          doc = pw.Document();
          doc.addPage(pw.Page(
            build: (pw.Context context) {
              return pw.Column(children: 
                list.map((e) => pw.SizedBox(
                  // ignore: prefer_const_constructors
                  child: pw.Column(children: [
                    pw.Text(e, style: pw.TextStyle(fontSize: 40)),
                    pw.Text(widget.invoice[indexOf(list, e)], style: pw.TextStyle(fontSize: 30)),
                  ])
                )).toList()
              );// Center
            }
          )
          ); 

          return ListTile(
            title: Text(list[index]),
            trailing: Column(children: [
              Text(
                widget.invoice[index],
              ),
            ],),
          );
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

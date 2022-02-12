import 'package:flutter/material.dart';

class CardBox extends StatefulWidget {
  const CardBox(
      {Key? key,
      required this.selectedValue,
      this.updateNum,
      required this.isClicked,
      this.updatePrice,
      required this.itemPrice})
      : super(key: key);

  final int selectedValue;
  final updateNum;
  final bool isClicked;
  final updatePrice;
  final String itemPrice;
  @override
  _CartCardBoxState createState() => _CartCardBoxState();
}

class _CartCardBoxState extends State<CardBox> {
  final itemFormKey = GlobalKey<FormState>();
  var value = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton<int>(
          items: const [
            DropdownMenuItem(
              child: Text("×1"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("×2"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("×3"),
              value: 3,
            ),
            DropdownMenuItem(
              child: Text("×4"),
              value: 4,
            ),
            DropdownMenuItem(
              child: Text("×5"),
              value: 5,
            )
          ],
          hint: const Text("num"),
          style: const TextStyle(fontSize: 15, color: Colors.green),
          underline: const Divider(
            height: 1,
            color: Colors.blue,
          ),
          value: value, 
          onChanged: (int? newValue) {
            setState(() {
              if (widget.isClicked) {
                widget.updatePrice(
                    (newValue! - value) * int.parse(widget.itemPrice));
              }
              value = newValue!;
              widget.updateNum(value);
            });
          },
          onTap: () {},
        ),
      ],
    );
  }
}
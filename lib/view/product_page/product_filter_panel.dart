import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_card.dart';
import 'product_edit.dart';
import '../../components/invisible_dropdown.dart';

class ProductFilterPanel extends StatefulWidget {
  const ProductFilterPanel({ Key? key, required this.originProducts, required this.products, this.onSelectFinish, this.onEditFinish, required this.isMerchant }) : super(key: key);

  final List<Product> products;
  final List<Product> originProducts;
  final bool isMerchant;
  final onEditFinish;
  final onSelectFinish;

  @override
  _ProductFilterPanelState createState() => _ProductFilterPanelState();
}

class _ProductFilterPanelState extends State<ProductFilterPanel> {
  bool priceAscending = true;
  
  @override
  void initState() {
    super.initState();
    priceAscending = true;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> sortList = List.from(widget.products);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 55,
        flexibleSpace: Row(children: <Widget>[
          Expanded(
              child: Center(
            child: TextButton(
              onPressed: () => {
                setState(() {
                  priceAscending = !priceAscending;
                }),
                priceAscending
                    ? sortList.sort((a, b) => a.price - b.price)
                    : sortList.sort((a, b) => b.price - a.price),
                widget.onSelectFinish(sortList)
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Prices", style: TextStyle(color: Colors.black)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up,
                          size: 18,
                          color: priceAscending ? Colors.black : Colors.grey),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18,
                          color: priceAscending ? Colors.grey : Colors.black)
                    ],
                  )
                ],
              ),
            ),
          )),
          Expanded(
            child: Stack(
              children: [
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.location_on),
                    Text("Location")
                  ],
                )),
                InvisibleDropdown(
                    type: "location",
                    products: widget.originProducts,
                    onFilterFinish: (value) => widget.onSelectFinish(value)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const <Widget>[
                        Text("Filter"),
                        Icon(Icons.filter_alt)
                      ],
                    )),
                InvisibleDropdown(
                  type: "type",
                  products: widget.originProducts,
                  onFilterFinish: (value) => widget.onSelectFinish(value)),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: widget.isMerchant, 
        maintainState: false,
        child: ProductEdit(
            product: Product(), onEditFinish: widget.onEditFinish, editRole: "add"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 2,
          childAspectRatio: 2 / 3.1,
        ),
        shrinkWrap: true,
        children: buildProductList(),
      ),
    );
  }

  List<ProductCard> buildProductList() {
    return widget.products.map((productsState) => ProductCard(product: productsState, isMarchant: widget.isMerchant, onEditFinish: widget.onEditFinish)).toList();
  }
}

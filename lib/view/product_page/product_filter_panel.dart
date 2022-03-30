import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_card.dart';
import 'product_edit.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../components/invisible_dropdown.dart';
import 'edit_catrgories.dart';

class ProductFilterPanel extends StatefulWidget {
  
  const ProductFilterPanel(
    {Key? key,
      required this.filters,
      required this.filters_select,
      required this.products,
      this.onSelectFinish,
      this.onEditFinish,
      required this.user})
      : super(key: key);

  final List<Product> products;
  final List<String> filters;
  final List<String> filters_select;
  final User user;
  final onEditFinish;
  final onSelectFinish;

  @override
  ProductFilterPanelState createState() => ProductFilterPanelState();
}

class ProductFilterPanelState extends State<ProductFilterPanel> {
  late String filters_dropdown_list;
  
  @override
  void initState() {
    super.initState();
    filters_dropdown_list = widget.filters[2];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 55,
        flexibleSpace: Row(children: <Widget>[
          Expanded(
              child: Center(
            child: TextButton(
              onPressed: () => {
                widget.onSelectFinish(
                     widget.filters_select[0] == 'ascending'
                        ? 'descending'
                        : 'ascending',
                    0)
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
                          color: widget.filters_select[0] == 'ascending'
                              ? Colors.black
                              : Colors.grey),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18,
                          color: widget.filters_select[0] == 'ascending'
                              ? Colors.grey
                              : Colors.black)
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
                    Text("Manufacture")
                  ],
                )),
                InvisibleDropdown(
                    options: widget.filters_select[1],
                    origins: widget.filters[1],
                    index: 1,
                    onFilterFinish: (value, index) =>
                        widget.onSelectFinish(value, index)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(widget.user.isMerchant ? null : Icons.filter_alt),
                        Text(widget.user.isMerchant ? "" : "Categories  ")
                      ],
                  )
                ),
                Visibility(
                  visible: !widget.user.isMerchant,
                  maintainState: false,
                  child: InvisibleDropdown(
                    options: widget.filters_select[2],
                    origins: widget.filters[2],
                    index: 2,
                    onFilterFinish: (value, index) =>
                        widget.onSelectFinish(value, index))),
                Visibility(
                  visible: widget.user.isMerchant,
                  maintainState: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 120)),
                      const Icon(Icons.edit),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return EditCate(options: filters_dropdown_list, onCateEditFinish: onCateEditFinish);
                            }),
                          );
                        },
                        child: const Text("Edit Categories",
                          style: TextStyle(
                            color: Colors.black, fontSize: 14)))
                    ]
                  )
                )
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: widget.user.isMerchant,
        maintainState: false,
        child: ProductEdit(
            product: Product(), onEditFinish: widget.onEditFinish, editRole: "add", filters_dropdown_list: filters_dropdown_list),
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

  void onCateEditFinish(List<String> res) {
    String list = "";
    for (String s in res) {
      list += s;
      list += "_";
    }
    setState(() {
      filters_dropdown_list = list.substring(0, list.length - 1);
    });
  }

  List<ProductCard> buildProductList() {
    return widget.products
      .map((productsState) => ProductCard(
        product: productsState, user: widget.user, onEditFinish: widget.onEditFinish, filters_dropdown_list: filters_dropdown_list))
      .toList();
  }
}

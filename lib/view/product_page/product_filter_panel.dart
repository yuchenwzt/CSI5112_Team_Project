import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_card.dart';
import 'product_edit.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../components/invisible_dropdown.dart';
import 'edit_catrgories.dart';

class ProductFilterPanel extends StatelessWidget {
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
                onSelectFinish(
                    filters_select[0] == 'ascending'
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
                          color: filters_select[0] == 'ascending'
                              ? Colors.black
                              : Colors.grey),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18,
                          color: filters_select[0] == 'ascending'
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
                    options: filters_select[1],
                    origins: filters[1],
                    index: 1,
                    onFilterFinish: (value, index) =>
                        onSelectFinish(value, index)),
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
                    //const Text("Category"),

                    Visibility(
                        visible: !user.isMerchant,
                        child: const Text("Category")),

                    Visibility(
                        visible: !user.isMerchant,
                        child: const Icon(Icons.filter_alt)),
                  ],
                )),
                Visibility(
                    visible: !user.isMerchant,
                    child: InvisibleDropdown(
                        options: filters_select[2],
                        origins: filters[2],
                        index: 2,
                        onFilterFinish: (value, index) =>
                            onSelectFinish(value, index))),
                Visibility(
                    visible: user.isMerchant,
                    maintainState: false,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.only(top: 120)),
                          const Icon(Icons.edit),
                          TextButton(
                              onPressed: () {
                                //showFormDialog(context, origins);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return EditCate();
                                  }),
                                );
                              },
                              child: const Text("Edit Categories",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14)))
                        ]))
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: user.isMerchant,
        maintainState: false,
        child: ProductEdit(
            product: Product(), onEditFinish: onEditFinish, editRole: "add"),
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
    return products
        .map((productsState) => ProductCard(
            product: productsState, user: user, onEditFinish: onEditFinish))
        .toList();
  }
}

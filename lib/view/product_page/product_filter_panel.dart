import 'package:csi5112_project/components/suspend_page.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import 'product_card.dart';
import 'product_edit.dart';
import 'package:csi5112_project/data/user_data.dart';
import '../../components/invisible_dropdown.dart';
import 'edit_catrgories.dart';
import 'package:provider/provider.dart';

class ProductFilterPanel extends StatefulWidget {
  
  ProductFilterPanel(
    {Key? key,
      required this.filters,
      required this.filters_select,
      required this.products,
      this.onSelectFinish,
      this.onEditFinish,
      this.onCateUpdateFinish,
      required this.user,
      required this.isLoadError,
      required this.isSearching,
      required this.loadError,
      this.retry
      })
      : super(key: key);

  final List<Product> products;
  final List<String> filters;
  final List<String> filters_select;
  final User user;
  final onEditFinish;
  final onSelectFinish;
  final onCateUpdateFinish;
  final bool isLoadError;
  final bool isSearching;
  final String loadError;
  final retry;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    filters_dropdown_list = Provider.of<String>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 255, 0.5),
      appBar: AppBar(
        // backgroundColor: const Color.fromRGBO(160, 160, 160, 0.5),
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
                              return EditCate(
                                options: filters_dropdown_list, 
                                onCateAddFinish: onCateAddFinish,
                                onCateUpdateFinish: widget.onCateUpdateFinish,
                              );
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
        visible: true,
        maintainState: false,
        child: widget.user.isMerchant ? ProductEdit(
            product: Product(), onEditFinish: widget.onEditFinish, editRole: "add", filters_dropdown_list: filters_dropdown_list)
            : FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                widget.retry();
              },
            ),
      ),
      body: SuspendCard(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisSpacing: 2,
            childAspectRatio: 2 / 3.1,
          ),
          shrinkWrap: true,
          children: buildProductList(),
        ), 
        isLoadError: widget.isLoadError, 
        isSearching: widget.isSearching, 
        loadError: widget.loadError, 
        data: widget.products, 
        retry: widget.retry
      ),
    );
  }

  void onCateAddFinish(List<String> res) {
    String list = "";
    bool flag = false;
    for (String s in res) {
      if (s != "") {
        list += s;
        list += "_";
      } else {
        flag = true;
      }
    }
    if (flag) list += '_';
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

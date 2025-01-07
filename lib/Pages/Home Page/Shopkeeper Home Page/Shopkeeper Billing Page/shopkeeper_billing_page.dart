import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:the_shavi/Reusable%20Function/reusable_funtion.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';
import 'package:the_shavi/Reusable%20widgets/my_search_item.dart';
import 'package:the_shavi/Reusable%20widgets/my_shop_items_category.dart';
import 'package:the_shavi/Reusable%20widgets/my_widget.dart';
// import 'package:theshavi/New/Reusable%20fuctions/reusable_functions_variables.dart';
// import 'package:theshavi/New/Reusable%20widgets/my_products.dart';
// import 'package:theshavi/New/Reuseable%20Values/reusable_values.dart';

class ShopkeeprBillingPage extends StatefulWidget {
  const ShopkeeprBillingPage(
      {super.key,
      required this.customerName,
      required this.customerMobileNumber});
  final String customerName;
  final String customerMobileNumber;
  @override
  State<ShopkeeprBillingPage> createState() => _ShopkeeprBillingPageState();
}

class _ShopkeeprBillingPageState extends State<ShopkeeprBillingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyUserPageDetails.color,
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.customerName == ''
                        ? 'Customer'
                        : widget.customerName),
                    if (widget.customerMobileNumber != "+91")
                      Text(widget.customerMobileNumber,
                          style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: badgeValue,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Badge.count(
                      count: value,
                      //MyFun.bagecount(widget.storeData['cart']),
                      // widget.storeData['cart'].length,
                      alignment: const AlignmentDirectional(.2, -.8),
                      child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CartPage(
                            //             storeData: widget.storeData)));
                          },
                          icon: const Icon(Icons.shopping_cart_outlined)),
                    );
                  })
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              mySearchItem(),
              if (MyFun.isWebOrRotate(context)) MyWidget.gapBwWidgets(),
              MyShopItemsCaterory(
                  numberOfLoop: MyshopDetails.shopItemsCategory.length,
                  categoryList: MyshopDetails.shopItemsCategory,
                  refesh: () {}),
              Divider(
                height: 1,
              ),
              // for(int i=0;i<=10;i++)
              // myItem(),
              itemsCard()
            ],
          ),
        ));
  }

  Widget itemsCard() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ResponsiveGridList(
              minItemWidth: MyFun.isWebOrRotate(context) ? 350 : 150,
              horizontalGridMargin: 0,
              verticalGridSpacing: 0,
              children: [
                for (int i = 0; i <= 5; i++)
                  SizedBox(
                      height: MyFun.isWebOrRotate(context) ? 450 : 300,
                      child: myItem()),
              ]),
        ));
  }

  Widget myItem() {
    return Card(
      child: Column(
        children: [
          Image.asset('assets/Jewellery.jpg'),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subtitle'),
                        Text('Subtitle'),
                        Text('Subtitle'),
                      ],
                    ),
                    productTrailingUser({})
                  ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
Widget productTrailingUser(Map<String, dynamic> allData) {
    print('vijay $allData');
   // String data = allData['productId'];
    bool productInCart = false;
    // String selectedShopCategory =
    //     MyFun.selectedShopCategory(shopData, allCategoryProductIds, data);
    // if (widget.cart.containsKey(selectedShopCategory)) {
    //   {
    //     if (widget.cart[selectedShopCategory]!.containsKey(data)) {
    //       productInCart = true;
    //     }
    //   }
    // }
    return productInCart == false
        ? myButton(75, '+ADD', () {
            if (allData['pQty'] != 0 && allData['pQty'] != null) {
              setState(() {
                badgeValue.value++;
                // if (widget.cart.containsKey(selectedShopCategory)) {
                //   widget.cart[selectedShopCategory]!.addAll({data: 1});
                //   MyDbFun.updateCart(
                //       widget.shopkeerpeMobileNumber, widget.cart);
                // } else {
                //   widget.cart.addAll({
                //     selectedShopCategory: {data: 1}
                //   });
                //   MyDbFun.updateCart(
                //       widget.shopkeerpeMobileNumber, widget.cart);
                // }
              });
            }
          })
        : SizedBox(
            height: 30,
            width: 80,
            child: Row(
              children: [
                myButton(20, '-', () {
                  setState(() {
                    // if (widget.cart[selectedShopCategory]![data] <= 1) {
                    //   widget.cart[selectedShopCategory]!.remove(data);
                    //   badgeValue.value--;
                    // } else {
                    //   widget.cart[selectedShopCategory]![data] =
                    //       widget.cart[selectedShopCategory]![data] - 1;
                    // }
                    // MyDbFun.updateCart(
                    //     widget.shopkeerpeMobileNumber, widget.cart);
                  });
                }),
                myTextField(allData),
                myButton(20, '+', () {
                  setState(() {
                    // if (widget.cart[selectedShopCategory]![data] <
                    //     allData['pQty']) {
                    //   widget.cart[selectedShopCategory]![data] =
                    //       widget.cart[selectedShopCategory]![data] + 1;
                    //   MyDbFun.updateCart(
                    //       widget.shopkeerpeMobileNumber, widget.cart);
                    // } else {
                    //   MyFun.natification(
                    //       "Only ${allData['pQty']} items are available",
                    //       context);
                    // }
                  });
                })
              ],
            ),
          );
  }
  Widget myButton(double width, String data, onTap) {
    int? parsedInt = int.tryParse(data);
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
          color: parsedInt != null
              ? Colors.transparent
              : data == 'Exist'
                  ? Colors.grey
                  : Colors.green,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
          data,
          style: TextStyle(
              color: parsedInt == null ? Colors.white : Colors.black,
              fontSize: 16),
        )),
      ),
    );
  }
  Widget myTextField(allData) {
    String data = allData['productId'];
    final controllerCart = TextEditingController();
    // String selectedShopCategory =
    //     MyFun.selectedShopCategory(shopData, allCategoryProductIds, data);
    // controllerCart.text = widget.cart[selectedShopCategory]![data].toString();
    return Flexible(
      child: TextField(
        controller: controllerCart,
        keyboardType: TextInputType.number,
        showCursor: false,
        decoration:
            const InputDecoration(border: InputBorder.none, counterText: ''),
        textAlign: TextAlign.center,
        enableInteractiveSelection: false,
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
        onSubmitted: (value) {
          // if (value == '' || int.parse(value) == 0) {
          //   setState(() {
          //     widget.cart[selectedShopCategory]!.remove(data);
          //     MyDbFun.updateCart(widget.shopkeerpeMobileNumber, widget.cart);
          //   });
          // } else if (int.parse(value) > allData['pQty']) {
          //   setState(() {
          //     controllerCart.text =
          //         widget.cart[selectedShopCategory]![data].toString();
          //         MyFun.natification(
          //                 "Only ${allData['pQty']} items are available",
          //                 context);
          //   });
          // } else {
          //   setState(() {
          //     widget.cart[selectedShopCategory]![data] = int.parse(value);
          //     MyDbFun.updateCart(widget.shopkeerpeMobileNumber, widget.cart);
          //   });
          // }
        },
      ),
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:theshavi/New/Pages/Home%20Page/User/YourStore/payment.dart';
// import 'package:theshavi/New/Pages/Home%20Page/home_page.dart';
// import 'package:theshavi/New/Reusable%20fuctions/reusable_functions_variables.dart';
// import 'package:theshavi/New/Reusable%20widgets/bar_qr_code.dart';
// import 'package:theshavi/New/Reusable%20widgets/reusable_widgets.dart';
// import 'package:theshavi/New/Reusable%20widgets/shop_category.dart';
// import 'package:theshavi/New/Reuseable%20Values/reusable_values.dart';

// class MyProducts extends StatefulWidget {
//   const MyProducts(
//       {super.key,
//       required this.shopkeerpeMobileNumber,
//       required this.cart,
//       required this.page});
//   final String shopkeerpeMobileNumber;
//   final Map<String, dynamic> cart;
//   final String page;
//   @override
//   State<MyProducts> createState() => _MyProductsState();
// }

// class _MyProductsState extends State<MyProducts> {
//   final controllerInitialProductQuantity = TextEditingController();
//   final controllerSelectShopCategory = TextEditingController();
//   final controllerSearch = TextEditingController();
//   final _formfeild = GlobalKey<FormState>();
//   int currentIndex = 0;
//   double textSize = 1;
//   bool loading = false;
//   bool haveNewData = true;
//   List productDataIds = [];
//   Map<String, dynamic> allCategoryProductIds = {};
//   List existedProductIds = [];
//   Map<String, dynamic> selectedProductData = {};
//   List<Map<String, dynamic>> allData = [];
//   String paymentType = 'CoD';
//   Map<String, dynamic> shopData = {};

//   Widget badgeOfSN(element) {
//     int sn = productDataIds.indexOf(element);
//     return Container(color: Colors.red, child: Text(" ID-$sn "));
//   }

//   _async() async {
//     if (BarQrCodePage.barQrCodeValue != '') {
//       controllerSearch.text = BarQrCodePage.barQrCodeValue
//           .toString()
//           .replaceAll(RegExp('[^A-Za-z0-9]'), '');
//       BarQrCodePage.barQrCodeValue = '';
//     }
//     /*     page = 'shopPage';
//           page = 'masterPage';
//           //'userPage';
//     }*/
//     if (widget.page == 'cartPage') {
//       allCategoryProductIds.clear();
//       Map<String, dynamic> cart = widget.cart;
//       cart.forEach((key, value) {
//         List pid = [];
//         value.forEach((key1, value1) {
//           pid.add(key1);
//         });
//         allCategoryProductIds.addAll({key: pid});
//       });
//     } else {
//       allCategoryProductIds =
//           await MyDbFun.getProductIds(widget.shopkeerpeMobileNumber, context);
//     }
//     productDataIds.clear();
//     if (AppInitialValue.selectedShopCategory == 'ALL') {
//       for (int i = 0; i <= shopData['shopCategory'].length - 1; i++) {
//         if (allCategoryProductIds.containsKey(shopData['shopCategory'][i])) {
//           productDataIds
//               .addAll(allCategoryProductIds[shopData['shopCategory'][i]]);
//         }
//       }
//     } else {
//       if (allCategoryProductIds
//           .containsKey(AppInitialValue.selectedShopCategory)) {
//         productDataIds.addAll(
//             allCategoryProductIds[AppInitialValue.selectedShopCategory]);
//       }
//     }
//     _fatchData();
//   }

//   _fatchData() async {
//     int dataLength = allData.length;
//     setState(() {
//       loading = true;
//     });
//     int addNewItems = widget.page == 'cartPage'
//         ? productDataIds.length
//         : 4; //Number of items add

//     allData = await MyDbFun.searchProduct(
//         shopData,
//         allCategoryProductIds,
//         productDataIds,
//         controllerSearch.text.trim(),
//         allData,
//         widget.shopkeerpeMobileNumber,
//         addNewItems);
//     if (allData.length == dataLength) {
//       haveNewData = false;
//     }
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   initState() {
//     for (int i = 0; i <= AppInitialValue.shops.length - 1; i++) {
//       if (AppInitialValue.shops[i]['mobileNumber'] ==
//           widget.shopkeerpeMobileNumber) {
//         shopData = AppInitialValue.shops[i];
//       }
//     }

//     if (shopData['shopCategory']
//             .contains(AppInitialValue.selectedShopCategory) ==
//         false) {
//       AppInitialValue.selectedShopCategory = shopData['shopCategory'][0];
//     }
//     setState(() {
//       loading = true;
//     });
//     _async();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List categoryList = ['ALL'];
//     categoryList.addAll(shopData["shopCategory"]);
//     return SingleChildScrollView(
//       child: selectedProductData.isNotEmpty
//           ? productDetails()
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (widget.page == 'shopPage')
//                     Row(
//                       children: [
//                         const Expanded(
//                             child: Text(
//                           "Your Products",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green),
//                         )),
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, '/ProductDatabase');
//                             },
//                             icon: const Icon(
//                               Icons.storage_rounded,
//                               color: Colors.green,
//                             )),
//                         IconButton(
//                             onPressed: () {
//                               _updateProductList(context);
//                             },
//                             icon: const Icon(
//                               Icons.update,
//                               color: Colors.green,
//                             )),
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, '/AddProduct');
//                             },
//                             icon: const Icon(
//                               Icons.add_circle_outline,
//                               color: Colors.redAccent,
//                             ))
//                       ],
//                     ),
//                   MyWidget.gapBwWidgets(),
//                   TextFormField(
//                     controller: controllerSearch,
//                     onChanged: (text) async {
//                       haveNewData = true;
//                       allData.clear();
//                       for (int i = 1; i <= 1; i++) {
//                         Future.delayed(
//                           const Duration(seconds: 1),
//                         ).then((value) async {
//                           if (text != controllerSearch.text) {
//                             i = 0;
//                           } else {
//                             _fatchData();
//                           }
//                         });
//                       }
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Search Product by Name or ID',
//                         prefixIcon: const Icon(Icons.search),
//                         border: MyUi.border,
//                         suffixIcon: controllerSearch.text == ""
//                             ? IconButton(
//                                 icon: const Icon(Icons.qr_code),
//                                 onPressed: () {
//                                   MyFun.goToBarcodePage(
//                                       context, const HomePage());
//                                 },
//                               )
//                             : IconButton(
//                                 onPressed: () {
//                                   controllerSearch.text = '';
//                                   haveNewData = true;
//                                   allData.clear();
//                                   _fatchData();
//                                 },
//                                 icon: const Icon(
//                                   Icons.close_rounded,
//                                   color: Colors.red,
//                                 ))),
//                   ),
//                   if (shopData["shopCategory"].length != 1)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ShopCaterory(
//                           numberOfLoop: categoryList.length,
//                           categoryList: categoryList,
//                           refesh: () async {
//                             haveNewData = true;
//                             allData.clear();
//                             await _async();
//                           },
//                         ),
//                       ],
//                     ),
//                   if (loading) const Center(child: CircularProgressIndicator()),
//                   if (allData.isEmpty && loading == false)
//                     const Card(
//                       child: ListTile(
//                         title: Center(
//                           child: Text(
//                             'No Items',
//                             style: TextStyle(
//                                 color: Colors.red, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   for (int i = 0; i <= allData.length - 1; i++)
//                     if (allData[i].isNotEmpty)
//                       Badge(
//                         label: badgeOfSN(allData[i]['productId']),
//                         backgroundColor: Colors.transparent,
//                         alignment: const AlignmentDirectional(.7, -.8),
//                         child: Card(
//                           child: ListTile(
//                             title: productTitle(allData[i]),
//                             trailing: widget.page == 'masterPage'
//                                 ? productTrailingMaster(allData[i])
//                                 : widget.page == 'shopPage'
//                                     ? productTrailingShopkeeper(allData[i])
//                                     : productTrailingUser(allData[i]),
//                           ),
//                         ),
//                       ),
//                   if (haveNewData == true && widget.page != 'cartPage')
//                     TextButton(
//                         onPressed: () {
//                           _fatchData();
//                         },
//                         child: const Text(
//                           'more..',
//                           style: TextStyle(color: Colors.green),
//                         )),
//                   if (widget.page == 'cartPage' && allData.isNotEmpty == true)
//                     forCartPage(allData, widget.cart),
//                 ],
//               ),
//             ),
//     );
//   }

//   Future _updateProduct(context, Map<String, dynamic> dataForUpdate) async {
//     final controllerMRP = TextEditingController();
//     final controllerPrice = TextEditingController();
//     final controllerQuantity = TextEditingController();
//     final controllerMinQty = TextEditingController();
//     final controllerCartShop = TextEditingController();

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         controllerMRP.text = dataForUpdate['pMrp'].toString();
//         controllerPrice.text = dataForUpdate['pPrice'] != null
//             ? dataForUpdate['pPrice'].toString()
//             : '';
//         controllerQuantity.text = dataForUpdate['pQty'] != null
//             ? dataForUpdate['pQty'].toString()
//             : '';

//         controllerMinQty.text = dataForUpdate['MinimumQuantity'] ?? '';

//         return AlertDialog(
//           title: Text(dataForUpdate['product']),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Form(
//                   key: _formfeild,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MyWidget.textFormFeild(
//                           controllerMRP,
//                           "Please Enter MRP of Product",
//                           'MRP',
//                           TextInputType.number),
//                       MyWidget.textFormFeild(
//                           controllerPrice,
//                           "Please Enter Your Price",
//                           'Your Price',
//                           TextInputType.number),
//                       MyWidget.textFormFeild(
//                           controllerQuantity,
//                           "Please Enter Product Quantity",
//                           'Available Stoke',
//                           TextInputType.number),
//                       MyWidget.gapBwWidgets(),
//                       const Text(
//                         "Auto Add to Cart setting",
//                         style: TextStyle(
//                             color: Colors.red, fontWeight: FontWeight.bold),
//                       ),
//                       MyWidget.textFormFeild(
//                           controllerMinQty,
//                           "Please Enter Min Quantity to auto add in cart",
//                           'Minimum Available Stoke',
//                           TextInputType.number),
//                       MyWidget.textFormFeild(
//                           controllerCartShop,
//                           "Enter Mobile Number",
//                           'select shop',
//                           TextInputType.number)
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(color: Colors.red),
//               ),
//               onPressed: () async {
//                 MyDbFun.deleteProduct(
//                     productDataIds, dataForUpdate['productId'], context);
//               },
//             ),
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//                 child: const Text('Update'),
//                 onPressed: () async {
//                   if (_formfeild.currentState!.validate()) {
//                     Map<String, dynamic> newData = {
//                       "pMrp": double.parse(controllerMRP.text.trim()),
//                       "pQty": double.parse(controllerQuantity.text.trim()),
//                       "pPrice": double.parse(controllerPrice.text.trim()),
//                     };
//                     MyDbFun.updateProduct(
//                         dataForUpdate['productId'], newData, context);
//                   }
//                 }),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _updateProductList(context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Update Product List..'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(
//                     "Do you want to update your product list from Master Database?"),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: const Text('Update'),
//               onPressed: () async {
//                 print('vijay $allCategoryProductIds');
//                 MyDbFun.addMasterProducts(allCategoryProductIds, context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget productTitle(Map<String, dynamic> data) {
//     return InkWell(
//       child: Row(
//         children: [
//           if (selectedProductData.isEmpty)
//             SizedBox(height: 75, child: Image.network(data['FrontImageUrl'])),
//           MyWidget.gapBwWidgets(),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data['product'],
//                 style: TextStyle(
//                     fontSize: 15 * textSize, fontWeight: FontWeight.bold),
//                 softWrap: true,
//               ),
//               if (data['pSubCategory'] == '') MyWidget.gapBwWidgets(),
//               if (data['pSubCategory'] != '')
//                 Text(
//                   "(${data['pSubCategory']})",
//                   style: TextStyle(
//                     fontSize: 12 * textSize,
//                   ),
//                   softWrap: true,
//                 ),
//               Row(
//                 children: [
//                   Text(
//                     data['pValue'].toString(),
//                     style: TextStyle(fontSize: 12 * textSize),
//                   ),
//                   const SizedBox(
//                     width: 2,
//                   ),
//                   Text(
//                     data['pUnit'],
//                     style: TextStyle(fontSize: 12 * textSize),
//                   ),
//                 ],
//               ),
//               data['pQty'] != null && data['pQty'] != 0
//                   ? Text(
//                       data['pPrice'] == null
//                           ? "\u{20B9} ${data['pMrp'].toString()}"
//                           : "\u{20B9} ${data['pPrice'].toString()}",
//                       style: TextStyle(
//                           fontSize: 14 * textSize,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red),
//                     )
//                   : const Text(
//                       'Out of Stock',
//                       style: TextStyle(
//                           color: Colors.red, fontWeight: FontWeight.bold),
//                     ),
//               Text(
//                 "(MRP = \u{20B9}${data['pMrp'].toString()})",
//                 style: TextStyle(fontSize: 10 * textSize),
//               ),
//               MyWidget.gapBwWidgets(),
//             ],
//           ),
//         ],
//       ),
//       onTap: () {
//         setState(() {
//           selectedProductData.clear();
//           selectedProductData.addAll(data);
//         });
//       },
//     );
//   }

//   Widget productTrailingShopkeeper(Map<String, dynamic> data) {
//     return InkWell(
//       child: Column(
//         children: [
//           Text(
//             "Available Stoke",
//             style: TextStyle(fontSize: 8 * textSize),
//           ),
//           Container(
//             height: 25 * textSize,
//             width: 55 * textSize,
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: const BorderRadius.all(Radius.circular(8.0))),
//             child: Center(
//                 child: data['pQty'] == null
//                     ? const Text('Add')
//                     : Text(data['pQty'].toString())),
//           ),
//         ],
//       ),
//       onTap: () {
//         _updateProduct(context, data);
//       },
//     );
//   }

//   Widget productDetails() {
//     textSize = 1.5;
//     final myItems = [
//       Image.network(
//         selectedProductData['FrontImageUrl'],
//         fit: BoxFit.contain,
//       ),
//       Image.network(selectedProductData['BackImageUrl'], fit: BoxFit.contain),
//       Image.network(selectedProductData['BarCodeImageUrl'], fit: BoxFit.contain)
//     ];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(child: MyWidget.gapBwWidgets()),
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     selectedProductData.clear();
//                     textSize = 1;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.close,
//                   color: Colors.red,
//                 )),
//           ],
//         ),
//         CarouselSlider(
//             items: myItems,
//             options: CarouselOptions(
//                 autoPlay: true,
//                 height: MediaQuery.of(context).size.width * .8,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     currentIndex = index;
//                   });
//                 })),
//         MyWidget.gapBwWidgets(),
//         Center(
//             child: AnimatedSmoothIndicator(
//           activeIndex: currentIndex,
//           count: myItems.length,
//           effect: WormEffect(activeDotColor: MyUi.color),
//         )),
//         Badge(
//           label: badgeOfSN(selectedProductData['productId']),
//           backgroundColor: Colors.transparent,
//           alignment: const AlignmentDirectional(.7, -.8),
//           child: ListTile(
//             title: productTitle(selectedProductData),
//             trailing: productTrailingShopkeeper(selectedProductData),
//           ),
//         ),
//         if (selectedProductData['pDescription'] != null)
//           Padding(
//             padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Description',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 Text(selectedProductData['pDescription']),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget productTrailingUser(Map<String, dynamic> allData) {
//     print('vijay $allData');
//     String data = allData['productId'];
//     bool productInCart = false;
//     String selectedShopCategory =
//         MyFun.selectedShopCategory(shopData, allCategoryProductIds, data);
//     if (widget.cart.containsKey(selectedShopCategory)) {
//       {
//         if (widget.cart[selectedShopCategory]!.containsKey(data)) {
//           productInCart = true;
//         }
//       }
//     }
//     return productInCart == false
//         ? myButton(75, '+ADD', () {
//             if (allData['pQty'] != 0 && allData['pQty'] != null) {
//               setState(() {
//                 badgeValue.value++;
//                 if (widget.cart.containsKey(selectedShopCategory)) {
//                   widget.cart[selectedShopCategory]!.addAll({data: 1});
//                   MyDbFun.updateCart(
//                       widget.shopkeerpeMobileNumber, widget.cart);
//                 } else {
//                   widget.cart.addAll({
//                     selectedShopCategory: {data: 1}
//                   });
//                   MyDbFun.updateCart(
//                       widget.shopkeerpeMobileNumber, widget.cart);
//                 }
//               });
//             }
//           })
//         : SizedBox(
//             height: 30,
//             width: 80,
//             child: Row(
//               children: [
//                 myButton(20, '-', () {
//                   setState(() {
//                     if (widget.cart[selectedShopCategory]![data] <= 1) {
//                       widget.cart[selectedShopCategory]!.remove(data);
//                       badgeValue.value--;
//                     } else {
//                       widget.cart[selectedShopCategory]![data] =
//                           widget.cart[selectedShopCategory]![data] - 1;
//                     }
//                     MyDbFun.updateCart(
//                         widget.shopkeerpeMobileNumber, widget.cart);
//                   });
//                 }),
//                 myTextField(allData),
//                 myButton(20, '+', () {
//                   setState(() {
//                     if (widget.cart[selectedShopCategory]![data] <
//                         allData['pQty']) {
//                       widget.cart[selectedShopCategory]![data] =
//                           widget.cart[selectedShopCategory]![data] + 1;
//                       MyDbFun.updateCart(
//                           widget.shopkeerpeMobileNumber, widget.cart);
//                     } else {
//                       MyFun.natification(
//                           "Only ${allData['pQty']} items are available",
//                           context);
//                     }
//                   });
//                 })
//               ],
//             ),
//           );
//   }

//   Widget myButton(double width, String data, onTap) {
//     int? parsedInt = int.tryParse(data);
//     return Container(
//       height: 30,
//       width: width,
//       decoration: BoxDecoration(
//           color: parsedInt != null
//               ? Colors.transparent
//               : data == 'Exist'
//                   ? Colors.grey
//                   : Colors.green,
//           borderRadius: const BorderRadius.all(Radius.circular(8))),
//       child: InkWell(
//         onTap: onTap,
//         child: Center(
//             child: Text(
//           data,
//           style: TextStyle(
//               color: parsedInt == null ? Colors.white : Colors.black,
//               fontSize: 16),
//         )),
//       ),
//     );
//   }

//   Widget myTextField(allData) {
//     String data = allData['productId'];
//     final controllerCart = TextEditingController();
//     String selectedShopCategory =
//         MyFun.selectedShopCategory(shopData, allCategoryProductIds, data);
//     controllerCart.text = widget.cart[selectedShopCategory]![data].toString();
//     return Flexible(
//       child: TextField(
//         controller: controllerCart,
//         keyboardType: TextInputType.number,
//         showCursor: false,
//         decoration:
//             const InputDecoration(border: InputBorder.none, counterText: ''),
//         textAlign: TextAlign.center,
//         enableInteractiveSelection: false,
//         maxLength: 3,
//         inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
//         onSubmitted: (value) {
//           if (value == '' || int.parse(value) == 0) {
//             setState(() {
//               widget.cart[selectedShopCategory]!.remove(data);
//               MyDbFun.updateCart(widget.shopkeerpeMobileNumber, widget.cart);
//             });
//           } else if (int.parse(value) > allData['pQty']) {
//             setState(() {
//               controllerCart.text =
//                   widget.cart[selectedShopCategory]![data].toString();
//                   MyFun.natification(
//                           "Only ${allData['pQty']} items are available",
//                           context);
//             });
//           } else {
//             setState(() {
//               widget.cart[selectedShopCategory]![data] = int.parse(value);
//               MyDbFun.updateCart(widget.shopkeerpeMobileNumber, widget.cart);
//             });
//           }
//         },
//       ),
//     );
//   }

//   Widget productTrailingMaster(data) {
//     return existedProductIds.contains(data['productId'])
//         ? myButton(50, 'Exist', () {})
//         : myButton(75, '+ADD', () {
//             existedProductIds.add(data['productId']);
//             MyDbFun.updateProductIds(existedProductIds, context).then((value) {
//               setState(() {});
//             });
//           });
//   }

//   Widget forCartPage(List<Map<String, dynamic>> data, cart) {
//     double productMRP = 0;
//     double productPrice = 0;
//     for (int i = 0; i <= data.length - 1; i++) {
//       String selectedShopCategory = MyFun.selectedShopCategory(
//           shopData, allCategoryProductIds, data[i]['productId']);
//       if (data[i]['pQty'] != null &&
//           data[i]['pQty'] != 0 &&
//           widget.cart[selectedShopCategory][data[i]['productId']] != null) {
//         productMRP = productMRP +
//             data[i]['pMrp'] *
//                 widget.cart[selectedShopCategory][data[i]['productId']];
//         productPrice = productPrice +
//             (data[i]['pPrice'] ?? data[i]['pMrp']) *
//                 widget.cart[selectedShopCategory][data[i]['productId']];
//       } else {
//         MyFun.wait2Sec().then((value) => MyFun.natification(
//             'Price not including for Out of Stock Items..', context));
//       }
//     }
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text("MRP : \u{20B9} ${productMRP.toString()}"),
//             Text(
//                 'Discount : \u{20B9} ${(productMRP - productPrice).toString()}'),
//             const SizedBox(
//               height: 6,
//             ),
//             Text(
//               'Payable Amount : \u{20B9} ${productPrice.toString()}',
//               style: const TextStyle(
//                   fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.green)),
//                 child: Row(
//                   children: [
//                     myRadioButton("CoD"),
//                     const Text("Case on Delivery"),
//                     const SizedBox(
//                       width: 50,
//                     ),
//                     myRadioButton("Paying"),
//                     const Text("Pay Now"),
//                   ],
//                 ),
//               ),
//             ),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   String id = DateTime.now().toString();

//                   List itemsImage = [];
//                   Map<String, dynamic> orderData = {
//                     'cart': {
//                       AppInitialValue.selectedShopCategory:
//                           cart[AppInitialValue.selectedShopCategory]
//                     },
//                     'customerMobileNumber': AppInitialValue.userMobileNumber,
//                     'paymentStatus': paymentType
//                   };

//                   for (int i = 0; i <= data.length - 1; i++) {
//                     if (data[i]['pQty'] != null && data[i]['pQty'] != 0) {
//                       itemsImage.add(data[i]['FrontImageUrl']);
//                     }
//                   }
//                   Map<String, dynamic> dataforUser = {
//                     'shopName': shopData['shopName'],
//                     'itemsImage': itemsImage,
//                     'shopkeeperMobileNumber': widget.shopkeerpeMobileNumber,
//                     'status': 'Order Placed Successfully'
//                   };
//                   if (paymentType == 'CoD') {
//                     widget.cart.remove(AppInitialValue.selectedShopCategory);
//                     MyDbFun.updateCart(
//                         widget.shopkeerpeMobileNumber, widget.cart);
//                     MyDbFun.updateCollectionData('shops',
//                         widget.shopkeerpeMobileNumber, 'orders', id, orderData);
//                     MyDbFun.updateCollectionData(
//                         'users',
//                         AppInitialValue.userMobileNumber,
//                         'history',
//                         id,
//                         dataforUser);
//                     MyFun.backToHomePage(context);
//                   } else {
//                     MyFun.navigatToPage(
//                         context,
//                         PaymentPage(
//                             storeData: shopData,
//                             dataforUser: dataforUser,
//                             cart: cart,
//                             id: id,
//                             shopkeeperMobileNumber:
//                                 widget.shopkeerpeMobileNumber,
//                             orderData: orderData));
//                   }
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Place Order',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget myRadioButton(String value) {
//     return Radio(
//       //title: const Text("Case"),
//       value: value,
//       groupValue: paymentType,
//       onChanged: (value) {
//         setState(() {
//           paymentType = value.toString();
//         });
//       },
//     );
//   }
// }






// class MyProductSearchBox extends StatelessWidget {
//    MyProductSearchBox({super.key});
   
//  final controllerSearch = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return                   TextFormField(
//                     controller: controllerSearch,
//                     onChanged: (text) async {
//                       haveNewData = true;
//                       allData.clear();
//                       for (int i = 1; i <= 1; i++) {
//                         Future.delayed(
//                           const Duration(seconds: 1),
//                         ).then((value) async {
//                           if (text != controllerSearch.text) {
//                             i = 0;
//                           } else {
//                             _fatchData();
//                           }
//                         });
//                       }
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Search Product by Name or ID',
//                         prefixIcon: const Icon(Icons.search),
//                         border: MyUi.border,
//                         suffixIcon: controllerSearch.text == ""
//                             ? IconButton(
//                                 icon: const Icon(Icons.qr_code),
//                                 onPressed: () {
//                                   MyFun.goToBarcodePage(
//                                       context, const HomePage());
//                                 },
//                               )
//                             : IconButton(
//                                 onPressed: () {
//                                   controllerSearch.text = '';
//                                   haveNewData = true;
//                                   allData.clear();
//                                   _fatchData();
//                                 },
//                                 icon: const Icon(
//                                   Icons.close_rounded,
//                                   color: Colors.red,
//                                 ))),
//                   );;
//   }
// }











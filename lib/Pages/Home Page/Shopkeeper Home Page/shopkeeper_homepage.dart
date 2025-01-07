//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';

import '../../../Reusable Function/reusable_funtion.dart';
import 'Shopkeeper Billing Page/shopkeeper_billing_page.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:theshavi/New/Pages/Home%20Page/Shopkeeper/Home/billing_page.dart';
// import 'package:theshavi/New/Reusable%20fuctions/reusable_functions_variables.dart';
// import 'package:theshavi/New/Reuseable%20Values/reusable_values.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../User/Home/GoogleMap/google_map_page.dart';

class ShopkeeperHomePage extends StatefulWidget {
  const ShopkeeperHomePage({super.key});

  @override
  State<ShopkeeperHomePage> createState() => _ShopkeeperHomePageState();
}

class _ShopkeeperHomePageState extends State<ShopkeeperHomePage> {
  bool mobileNumberExist = true;
  final controllerMobile = TextEditingController();
  final controllerName = TextEditingController();
  final _formfeild = GlobalKey<FormState>();
  List orderDetails = [];
  String address = '';
  // CameraPosition location = AppInitialValue.currentCameraPosition;
  int productMRP = 0;
  int productPrice = 0;

  // getOrderDetails() {
  //   FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(AppInitialValue.userMobileNumber)
  //       .collection('order')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) async {
  //     orderDetails = [];
  //     for (var doc in querySnapshot.docs) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(doc['customer'])
  //           .get()
  //           .then((DocumentSnapshot customerDoc) {
  //         orderDetails.add({
  //           "customerName": customerDoc['name'],
  //           "address": customerDoc['address'],
  //           "addressLat": customerDoc['addressLat'],
  //           'addressLng': customerDoc['addressLng'],
  //           'customerMobile': customerDoc.id,
  //           "paymentType": doc['paymentType'],
  //           'productImage': doc['productImage'],
  //           'productMRP': doc['productMRP'],
  //           'productName': doc['productName'],
  //           'productPrice': doc['productPrice'],
  //           'productQty': doc['productQty'],
  //           'productUnit': doc['productUnit'],
  //           'productCategory': doc['productCategory'],
  //           'shopName': doc['shopName']
  //         });
  //       });
  //     }
  //   }).then((value) {
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    // getOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MediaQuery.of(context).size.width >= 960
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                expanded(),
                SizedBox(
                    width: 450,
                    height: MediaQuery.of(context).size.height - 200,
                    child: Column(
                      children: [expanded(), customerDetails(), expanded()],
                    )),
                expanded(),
                SizedBox(width: 300, child: onlineOrders())
              ],
            )
          : Column(
              children: [customerDetails(), onlineOrders()],
            ),
    );
  }

  Widget expanded() {
    return Expanded(
      child: Container(),
    );
  }

  Widget customerDetails() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formfeild,
            child: Column(
              children: [
                const Text(
                  'Customer Detail',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green)),
                  child: Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: mobileNumberExist,
                        onChanged: (value) {
                          setState(() {
                            mobileNumberExist = value!;
                            controllerMobile.text = '';
                            controllerName.text = '';
                          });
                        },
                      ),
                      const Text("Mobile Number"),
                      expanded(),
                      Radio(
                        //title: const Text("Pay Now"),
                        value: false,
                        groupValue: mobileNumberExist,
                        onChanged: (value) {
                          setState(() {
                            mobileNumberExist = value!;
                            controllerMobile.text = '';
                            controllerName.text = '';
                          });
                        },
                      ),
                      const Text("Don't have Mobile"),
                      expanded(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (mobileNumberExist)
                  TextFormField(
                    controller: controllerMobile,
                    readOnly: mobileNumberExist ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Mobile Number';
                      }
      
                      bool phoneValide =
                          RegExp(r'^([0-9]{10}$)').hasMatch(value.trim());
                      if (!phoneValide) {
                        return 'Enter Valid Mobile Number';
                      }
      
                      return null;
                    },
                    onChanged: (value) {
                      if (_formfeild.currentState!.validate()) {}
                    },
                    onTap: () {
                      if (_formfeild.currentState!.validate()) {}
                    },
                    keyboardType: TextInputType.phone,
                    decoration: MyReusableValue.textBoxDecoration(
                        'Mobile', const Icon(Icons.phone_android)),
                  ),
                if (mobileNumberExist)
                  const SizedBox(
                    height: 10,
                  ),
                if (mobileNumberExist)
                  TextFormField(
                    controller: controllerName,
                    readOnly: mobileNumberExist ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Customer Name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (_formfeild.currentState!.validate()) {}
                    },
                    decoration: MyReusableValue.textBoxDecoration('Customer Name',
                        const Icon(Icons.account_circle_outlined)),
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formfeild.currentState!.validate()) {
                        badgeValue.value=0;
                        MyFun.navigatToPage(
                            context,
                            ShopkeeprBillingPage(
                                customerName: controllerName.text,
                                customerMobileNumber:
                                    '+91${controllerMobile.text}')
                                    );
                      }
                    },
                    child: const Text('Start Billing'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget orderDisplay(i) {
  //   getPrice(i);
  //   return Card(
  //     color: Colors.green[100],
  //     child: ListTile(
  //       title: Row(
  //         children: [
  //           Expanded(
  //             child: Text(
  //               orderDetails[i]["customerName"],
  //               style: const TextStyle(
  //                   color: Colors.green,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 20),
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               launchUrl(
  //                   Uri.parse('tel://${orderDetails[i]['customerMobile']}'));
  //             },
  //             icon: const Icon(Icons.phone_forwarded_outlined),
  //             color: Colors.green,
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               launchUrl(Uri.parse(
  //                   'https://api.whatsapp.com/send?phone=${orderDetails[i]['customerMobile']}'));
  //             },
  //             icon: const FaIcon(FontAwesomeIcons.whatsapp),
  //             color: Colors.green,
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => GoogleMapPage(
  //                             location: LatLng(orderDetails[i]["addressLat"],
  //                                 orderDetails[i]["addressLng"]),
  //                           )));
  //             },
  //             icon: const FaIcon(FontAwesomeIcons.locationDot),
  //             color: Colors.green,
  //           ),
  //         ],
  //       ),
  //       subtitle: Column(
  //         children: [
  //           for (int j = 0; j <= orderDetails[i]['productName'].length - 1; j++)
  //             Card(
  //               child: ListTile(
  //                 title: Text(
  //                   orderDetails[i]['productName'][j],
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 leading: CircleAvatar(
  //                   radius: 20,
  //                   backgroundColor: Colors.white,
  //                   child: Image.network(orderDetails[i]['productImage'][j]),
  //                 ),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       orderDetails[i]['productUnit'][j],
  //                       style: const TextStyle(fontSize: 10),
  //                     ),
  //                     RichText(
  //                       text: TextSpan(
  //                         //  text: 'Price: \u{20B9} ${orderDetails[i]['productPrice'][j]} ',
  //                         style: DefaultTextStyle.of(context).style,
  //                         children: <TextSpan>[
  //                           TextSpan(
  //                               text:
  //                                   'Price: \u{20B9} ${orderDetails[i]['productPrice'][j]} ',
  //                               style: const TextStyle(
  //                                   fontWeight: FontWeight.bold)),
  //                           TextSpan(
  //                               text:
  //                                   '(MRP:\u{20B9}${orderDetails[i]['productMRP'][j]})',
  //                               style: const TextStyle(fontSize: 10)),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 trailing: Column(
  //                   children: [
  //                     InkWell(
  //                       child: const Icon(
  //                         Icons.close_outlined,
  //                         color: Colors.red,
  //                       ),
  //                       onTap: () {},
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(orderDetails[i]['productQty'][j]),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           Text('MRP :\u{20B9} ${productMRP.toString()}'),
  //           Text(
  //               "Discount : \u{20B9} ${(productMRP - productPrice).toString()}"),
  //           const SizedBox(
  //             height: 6,
  //           ),
  //           Text(
  //             'Payable Amount :\u{20B9} ${productPrice.toString()}',
  //             style: const TextStyle(
  //                 fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
  //           ),
  //           Text(
  //             'Payment Status : ${orderDetails[i]['paymentType']}',
  //             textAlign: TextAlign.center,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               ElevatedButton(
  //                 onPressed: () {
  //                   sendNotification(
  //                       DateTime.now().toString(),
  //                       'Order Rejected successfully',
  //                       'Your Order is not to be delivered by ${orderDetails[i]['shopName']}',
  //                       context,
  //                       orderDetails[i]['customerMobile'],
  //                       'users');
  //                 },
  //                 style: const ButtonStyle(
  //                   backgroundColor: MaterialStatePropertyAll(Colors.red),
  //                 ),
  //                 child: const Text('Reject'),
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               ElevatedButton(
  //                   onPressed: () {
  //                     sendNotification(
  //                         DateTime.now().toString(),
  //                         'Order Delivered successfully',
  //                         'Your Order is delivered successfully by ${orderDetails[i]['shopName']}',
  //                         context,
  //                         orderDetails[i]['customerMobile'],
  //                         'users');
  //                   },
  //                   child: const Text('   Delivered  ')),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget onlineOrders() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Card(
        child: Column(
          children: [
            const Text(
              'Online Orders..',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            if (orderDetails.isEmpty)
              const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
              'No Order Available.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
            // for (int i = 0; i <= orderDetails.length - 1; i++)
            //  orderDisplay(i)
          ],
        ),
      ),
    );
  }

  getPrice(i) {
    productMRP = 0;
    productPrice = 0;

    for (int l = 0; l <= orderDetails[i]['productPrice'].length - 1; l++) {
      productMRP = productMRP + int.parse(orderDetails[i]['productMRP'][l]);
      productPrice =
          productPrice + int.parse(orderDetails[i]['productPrice'][l]);
    }
  }
}

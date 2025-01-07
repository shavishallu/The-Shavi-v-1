import 'package:flutter/material.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';

import '../Pages/Home Page/home_page.dart';




class MyFun {
 static   bool isWebOrRotate(context) {
    if (MediaQuery.of(context).size.height >=
        MediaQuery.of(context).size.width) {
      return false;
    } else {
      return true;
    }
  }
  static backToHomePage(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  static natification(String msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
    ));
  }
  static Future<void> showMyDialog(
      String msg, bool iSBacktoHome, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alart'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                iSBacktoHome
                    ? MyFun.backToHomePage(context)
                    : Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> popUp(
      // ignore: non_constant_identifier_names
      String msg,
      // ignore: non_constant_identifier_names
      String Cancel,
      actionforCancel,
      // ignore: non_constant_identifier_names
      String OK,
      actionforOK,
      context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: actionforCancel,
              child: Text(Cancel),
            ),
            TextButton(
              onPressed: actionforOK,
              child: Text(OK),
            ),
          ],
        );
      },
    );
  }

  // static goToBarcodePage(context, page) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => BarQrCodePage(
  //               sourcePath: MaterialPageRoute(builder: (context) => page),
  //             )),
  //   );
  // }

  static Future navigatToPage(context, pageName) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
  }

  // static Future updateCurrentLocation() async {
  //   Position value = await getCurrentLocation();

  //   AppInitialValue.currentCameraPosition = CameraPosition(
  //       target: LatLng(
  //         value.latitude,
  //         value.longitude,
  //       ),
  //       zoom: 14);
  // }

  // static getMarker(context) {
  //   AppInitialValue.marker.clear();
  //   if (AppInitialValue.shops.isNotEmpty) {
  //     for (int i = 0; i <= AppInitialValue.shops.length - 1; i++) {
  //       if ((AppInitialValue.shops[i]['shopCategory'])
  //               .contains(AppInitialValue.selectedShopCategory) &&
  //           AppInitialValue.shops[i]['address'] != null) {
  //         AppInitialValue.marker.add(
  //           Marker(
  //             markerId: MarkerId(AppInitialValue.shops[i]['mobileNumber']),
  //             position: LatLng(AppInitialValue.shops[i]['LatLong'].latitude,
  //                 AppInitialValue.shops[i]['LatLong'].longitude),
  //             infoWindow: InfoWindow(
  //                 title: AppInitialValue.shops[i]['shopName'],
  //                 snippet:
  //                     "Delivary Range: ${AppInitialValue.shops[i]['DelivaryRange'].toString()} Meter",
  //                 onTap: () {
  //                   MyDbFun.addYourStore(
  //                       AppInitialValue.shops[i]['mobileNumber'],
  //                       AppInitialValue.shops[i]['shopName'],
  //                       context);
  //                 }),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }

  static bool isIntNumber(String number, bool isMobileNumber) {
    dynamic intNumber = int.tryParse(number);
    bool isInt = false;
    if (isMobileNumber) {
      if (intNumber != null &&
          intNumber >= 5000000000 &&
          intNumber <= 9999999999) {
        isInt = true;
      }
    } else {
      if (intNumber != null) {
        isInt = true;
      }
    }

    return isInt;
  }

  static Future wait2Sec() async {
    Future.delayed(const Duration(seconds: 2));
  }

  static selectedShopCategory(
      shopData, allCategoryProductIds, String productId) {
    String selectedShopCategory = '';
    if (MyUserDetails.selectedShopCategory == 'ALL') {
      for (int j = 0; j <= shopData["shopCategory"].length - 1; j++) {
        if (allCategoryProductIds.containsKey(shopData["shopCategory"][j])) {
          if (allCategoryProductIds[shopData["shopCategory"][j]]
              .contains(productId)) {
            selectedShopCategory = shopData["shopCategory"][j];
          }
        }
      }
    } else {
      selectedShopCategory = MyUserDetails.selectedShopCategory;
    }
    return selectedShopCategory;
  }

  static bagecount(Map<String, dynamic> cart) {
    int count = 0;
    cart.forEach((key, value) {
      value.forEach((key1, value1) {
        count++;
      });
    });
    return count;
  }
}

// class MyDbFun {
//   //DB functions for product data in Realtime Database

//   static Future uploadProduct(
//       String productId, Map<String, dynamic> data, context) async {
//     clearImagePath() {
//       AppInitialValue.imageFrontPath = '';
//       AppInitialValue.imageBackPath = '';
//       AppInitialValue.imageBarCodepath = '';
//     }

//     Future addUrlInData() async {
//       var name = ['FrontImageUrl', "BackImageUrl", "BarCodeImageUrl"];
//       final imagePath = [
//         AppInitialValue.imageFrontPath,
//         AppInitialValue.imageBackPath,
//         AppInitialValue.imageBarCodepath
//       ];
//       for (int i = 0; i <= 2; i++) {
//         File file = File(imagePath[i]);
//         String urlData =
//             await StoreDb.setDataAndGetUrl('$productId/${name[i]}', file);
//         if (urlData != 'error') {
//           data.addAll({name[i]: urlData});
//         } else {
//           MyFun.backToHomePage(context);
//         }
//       }
//     }

//     Map<String, dynamic> addProductId(Map<String, dynamic> allPId) {
//       if (allPId.containsKey(AppInitialValue.selectedShopCategory)) {
//         allPId[AppInitialValue.selectedShopCategory].add(productId);
//       } else {
//         allPId.addAll({
//           AppInitialValue.selectedShopCategory: [productId]
//         });
//       }
//       return allPId;
//     }

//     Future uploadDatainMaster(Map<String, dynamic> allMasterProductData,
//         Map<String, dynamic> allPId) async {
//       addUrlInData().then((value) {
//         allMasterProductData['barcode'].add(BarQrCodePage.barQrCodeValue);
//         BarQrCodePage.barQrCodeValue = '';
//         allMasterProductData = addProductId(allMasterProductData);
//         allPId = addProductId(allPId);
//         Db.setDocData('master', 'productData', allMasterProductData, true);
//         Db.setC1DocData('shops', AppInitialValue.userMobileNumber,
//             'productsIds', 'productsIds', allPId, true);
//         String path =
//             'Products/masterProducts/${AppInitialValue.selectedShopCategory} Products/$productId';
//         RtDb.setDB(path, data, context).then((value) {
//           clearImagePath();
//           MyFun.showMyDialog("Product Added Successfully", true, context);
//         });
//       });
//     }

//     Future searchDatainMaster(allPId) async {
//       if (BarQrCodePage.barQrCodeValue != '') {
//         DocumentSnapshot<Object?> masterProductData = await Db.readDocData(
//           'master',
//           'productData',
//         );
//         if (masterProductData.exists) {
//           Map<String, dynamic> allMasterProductData =
//               masterProductData.data() as Map<String, dynamic>;
//           List masterBarcode = allMasterProductData['barcode'];
//           if (masterBarcode.contains(BarQrCodePage.barQrCodeValue)) {
//             BarQrCodePage.barQrCodeValue = '';
//             clearImagePath();
//             MyFun.showMyDialog(
//                 "Product already exist in master database", true, context);
//           } else {
//             uploadDatainMaster(allMasterProductData, allPId);
//           }
//         } else {
//           Map<String, dynamic> allMasterProductData = {'barcode': []};
//           uploadDatainMaster(allMasterProductData, allPId);
//         }
//       } else {
//         addUrlInData().then((value) {
//           addProductId(allPId);
//           Db.setC1DocData('shops', AppInitialValue.userMobileNumber,
//               'productsIds', 'productsIds', allPId, true);
//           String path =
//               'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} Products/$productId';
//           RtDb.setDB(path, data, context).then((value) {
//             clearImagePath();
//             MyFun.showMyDialog("Product Added Successfully", true, context);
//           });
//         });
//       }
//     }

//     DocumentSnapshot pId = await Db.readC1DocData('shops',
//         AppInitialValue.userMobileNumber, 'productsIds', 'productsIds');
//     if (pId.exists) {
//       Map<String, dynamic> allPId = pId.data() as Map<String, dynamic>;
//       if (allPId.containsKey(AppInitialValue.selectedShopCategory)) {
//         List categoryPId = allPId[AppInitialValue.selectedShopCategory] as List;
//         if (categoryPId.contains(productId)) {
//           clearImagePath();
//           MyFun.showMyDialog('Product Already exist', true, context);
//         } else {
//           searchDatainMaster(allPId);
//         }
//       } else {
//         searchDatainMaster(allPId);
//       }
//     } else {
//       Map<String, dynamic> allPId = {};
//       searchDatainMaster(allPId);
//     }
//   }

//   static Future<Map<String, dynamic>> getProductIds(
//       String user, context) async {
//     DocumentSnapshot productsIds =
//         await Db.readC1DocData('shops', user, 'productsIds', 'productsIds');
//     if (productsIds.exists) {
//       Map<String, dynamic> productDataIdsData =
//           productsIds.data() as Map<String, dynamic>;
//       return productDataIdsData;
//     } else {
//       return {};
//     }
//   }

//   static Future<List<Map<String, dynamic>>> searchProduct(
//       Map<String, dynamic> shopData,
//       Map<String, dynamic> allCategoryProductIds,
//       List productDataIds,
//       String searchValue,
//       List<Map<String, dynamic>> data,
//       String shopkeeperMobile,
//       int addNewItems) async {
//     String search = searchValue.toLowerCase();
//     String dataForSearch = '';
//     List sortData = [];
//     int maxProductIdLength = 0;
//     List sortedProductDataIds = [];
//     int dataLength = 0;
//     // Search by ID
//     int? parsedInt = int.tryParse(search);
//     if (parsedInt != null && parsedInt < productDataIds.length) {
//       sortedProductDataIds.add(productDataIds[parsedInt]);
//     } else {
//       //Search product
//       if (searchValue != '') {
//         for (int i = 0; i <= productDataIds.length - 1; i++) {
//           for (int j = 0; j <= productDataIds[i].length - search.length; j++) {
//             for (int k = 0; k <= search.length - 1; k++) {
//               dataForSearch = dataForSearch + productDataIds[i][j + k];
//             }
//             if (dataForSearch == search) {
//               sortData.add({"index": i, "level": j});
//               j = productDataIds[i].length - 1;
//             }
//             dataForSearch = '';
//             if (j >= maxProductIdLength) {
//               maxProductIdLength = j;
//             }
//           }
//         }
//         for (int j = 0; j <= maxProductIdLength - 1; j++) {
//           for (int i = 0; i <= sortData.length - 1; i++) {
//             if (sortData[i]["level"] == j) {
//               sortedProductDataIds.add(productDataIds[sortData[i]["index"]]);
//             }
//           }
//         }
//       } else {
//         sortedProductDataIds.addAll(productDataIds);
//       }
//     }
//     if (data.isNotEmpty) {
//       dataLength =
//           sortedProductDataIds.indexOf(data[data.length - 1]["productId"]) + 1;
//     }
//     for (int i = dataLength; i <= sortedProductDataIds.length - 1; i++) {
//       String selectedShopCategory = MyFun.selectedShopCategory(
//           shopData, allCategoryProductIds, sortedProductDataIds[i]);

//       String path =
//           'Products/$shopkeeperMobile/$selectedShopCategory Products/${sortedProductDataIds[i]}';
//       Map<String, dynamic> productdata = {};
//       await RtDb.readData(path).then((value) async {
//         if (value == null || value['product'] == null) {
//           String path =
//               'Products/masterProducts/$selectedShopCategory Products/${sortedProductDataIds[i]}';
//           await RtDb.readData(path).then((value1) {
//             if (value1 != null) {
//               productdata.addAll(Map<String, dynamic>.from(value1 as Map));
//             }
//           });
//         }
//         if (value != null) {
//           productdata.addAll(Map<String, dynamic>.from(value as Map));
//         }

//         productdata.addAll({'productId': sortedProductDataIds[i]});
//         data.add(productdata);
//       });
//       addNewItems--;
//       if (addNewItems == 0) {
//         i = sortedProductDataIds.length;
//       }
//     }
//     return data;
//   }

//   static Future deleteProduct(productIds, productId, context) async {
//     productIds.remove(productId);
//     String path =
//         'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} ProductsIds';
//     RtDb.setDB(path, productIds, context).then((value) async {
//       path =
//           'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} Products/$productId';
//       await RtDb.deleteData(path).then((value) {
//         MyFun.natification('Product Deleted Successfully', context);
//         MyFun.backToHomePage(context);
//       });
//     });
//   }

//   static Future updateProduct(productId, value, context) async {
//     String path =
//         'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} Products/$productId';
//     RtDb.updateData(path, value).then((value) {
//       MyFun.backToHomePage(context);
//     });
//   }

//   static Future addMasterProducts(
//       Map<String, dynamic> allCategoryProductIds, context) async {
//     bool idUpdated = false;
//     DocumentSnapshot masterProductDataIdsSnapshot =
//         await Db.readDocData('master', 'productData');
//     if (masterProductDataIdsSnapshot.exists) {
//       Map<String, dynamic> masterProductDataIds =
//           masterProductDataIdsSnapshot.data() as Map<String, dynamic>;

//       masterProductDataIds.forEach((key, value) {
//         if (AppInitialValue.shopData['shopCategory'].contains(key)) {
//           List pid = masterProductDataIds[key] ?? [];
//           if (allCategoryProductIds.containsKey(key) == false) {
//             allCategoryProductIds.addAll({key: []});
//           }
//           for (int i = 0; i <= pid.length - 1; i++) {
//             if (allCategoryProductIds[key].contains(pid[i]) == false) {
//               idUpdated = true;
//               allCategoryProductIds[key].add(pid[i]);
//             }
//           }
//         }
//       });
//     }
//     if (idUpdated) {
//       Db.setC1DocData('shops', AppInitialValue.userMobileNumber, 'productsIds',
//               'productsIds', allCategoryProductIds, true)
//           .then((value) {
//         MyFun.natification('Your Products list is updated', context);
//         MyFun.backToHomePage(context);
//       });
//     } else {
//       MyFun.natification('Your product list is alredy upto date', context);
//       MyFun.backToHomePage(context);
//     }
//     // String path =
//     //     'Products/masterProducts/${AppInitialValue.selectedShopCategory} ProductsIds';
//     // await RtDb.readData(path).then((masterProductDataIds) {
//     //   if (masterProductDataIds != null) {
//     //     for (int i = 0; i <= masterProductDataIds.length - 1; i++) {
//     //       if (productIds.contains(masterProductDataIds[i]) == false) {
//     //         productIds.add(masterProductDataIds[i]);
//     //       }
//     //     }
//     //     path =
//     //         'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} ProductsIds';
//     //     RtDb.setDB(path, productIds, context).then((value) {
//     //       MyFun.natification(
//     //           'Your Product list is updated from Master Database', context);
//     //       MyFun.backToHomePage(context);
//     //     });
//     //   } else {
//     //     MyFun.natification('Master Database is not exist', context);
//     //     MyFun.backToHomePage(context);
//     //   }
//     // });
//   }

//   static Future updateProductIds(data, context) async {
//     String path =
//         'Products/${AppInitialValue.userMobileNumber}/${AppInitialValue.selectedShopCategory} ProductsIds';
//     RtDb.setDB(path, data, context).then((value) {
//       MyFun.natification('Product Added', context);
//     });
//   }

// //DB funtions for Firebase Database
//   static Future updateCart(String shopkeeperMobile, cartData) async {
//     if (shopkeeperMobile != AppInitialValue.userMobileNumber) {
//       await Db.updateC1DocData('users', AppInitialValue.userMobileNumber,
//           'yourStores', shopkeeperMobile, {'cart': cartData});
//     }
//   }

//   static checkUserExist(context) async {
//     final formfeild = GlobalKey<FormState>();
//     DocumentSnapshot documentSnapshot =
//         await Db.readDocData('users', AppInitialValue.userMobileNumber);

//     if (documentSnapshot.exists) {
//       AppInitialValue.userData =
//           documentSnapshot.data() as Map<String, dynamic>;
//       if (AppInitialValue.userData['LatLong'] == null) {
//         MyFun.popUp(
//             'Please Update your Delivary Location',
//             'Cancel',
//             () {
//               MyFun.natification('Delivary address is required', context);
//             },
//             'OK',
//             () {
//               MyFun.navigatToPage(context,
//                   const AddGoogleMapAddressPage(dBcollection: 'users'));
//             },
//             context);
//       }
//     } else {
//       MyFun.popUp(
//           'Are you a Shopkeeper?',
//           'Yes',
//           () {
//             AppInitialValue.userType = 'shopkeeper';
//             MyFun.navigatToPage(context, const AddShopkeeperPage());
//           },
//           'No',
//           () {
//             AppInitialValue.userType = 'user';
//             showDialog(
//               context: context,
//               barrierDismissible: false, // user must tap button!
//               builder: (BuildContext context) {
//                 final controllerName = TextEditingController();
//                 controllerName.text = AppInitialValue.userData['name'] ?? '';
//                 return Form(
//                   key: formfeild,
//                   child: AlertDialog(
//                     content: SingleChildScrollView(
//                       child: ListBody(
//                         children: <Widget>[
//                           const Text('Enter your Name'),
//                           TextFormField(
//                             controller: controllerName,
//                             validator: (value) {
//                               if (value == '') {
//                                 return 'Enter your Name';
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     actions: <Widget>[
//                       if (AppInitialValue.userData['name'] == null)
//                         MyWidget.cancelButton(context),
//                       TextButton(
//                         child: const Text('OK'),
//                         onPressed: () {
//                           if (formfeild.currentState!.validate()) {
//                             Map<String, dynamic> userData = {
//                               "name": controllerName.text.trim(),
//                               'userType': 'user'
//                             };
//                             AppInitialValue.userData.addAll(userData);
//                             MyDbFun.updateUserData(userData);
//                             MyFun.navigatToPage(
//                                 context,
//                                 const AddGoogleMapAddressPage(
//                                     dBcollection: 'users'));
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//           context);

//       /* showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: const Text('Are you a Shopkeeper?'),
//             actions: <Widget>[
//               TextButton(
//                   onPressed: () {
//                     AppInitialValue.userType = 'shopkeeper';
//                     MyFun.navigatToPage(context, const AddShopkeeperPage());
//                   },
//                   child: const Text(
//                     'Yes',
//                   )),
//               TextButton(
//                   onPressed: () {
//                     AppInitialValue.userType = 'users';
//                     updateuser();
//                   },
//                   child: const Text(
//                     'No',
//                   )),
//             ],
//           );
//         },
//       );*/
//     }
//   }

//   static Future updateUserData(data) async {
//     await Db.setDocData('users', AppInitialValue.userMobileNumber, data, true);
//   }

//   static Future updateShopData(data) async {
//     await Db.setDocData('shops', AppInitialValue.userMobileNumber, data, true);
//   }

//   static Future getShopsData() async {
//     QuerySnapshot shopsData = await Db.readAllData('shops');
//     if (shopsData.docs.isNotEmpty) {
//       AppInitialValue.shops.clear();
//       for (var doc in shopsData.docs) {
//         Map<String, dynamic> shopData = doc.data() as Map<String, dynamic>;
//         shopData.addAll({'mobileNumber': doc.id});
//         if (doc.id == AppInitialValue.userMobileNumber) {
//           AppInitialValue.shopData.clear();
//           AppInitialValue.shopData.addAll(shopData);
//         }
//         AppInitialValue.shops.add(shopData);
//       }
//     }
//   }

//   static Future<Map<String, dynamic>> readUserData(
//       String mobileNumber, String collectionPath, String docPath) async {
//     DocumentSnapshot userData = collectionPath == ''
//         ? await Db.readDocData('users', mobileNumber)
//         : await Db.readC1DocData(
//             'users', mobileNumber, collectionPath, docPath);
//     if (userData.exists) {
//       return userData.data() as Map<String, dynamic>;
//     } else {
//       return {};
//     }
//   }

//   static Future updateData(
//     collectionPath,
//     docPath,
//     data,
//   ) async {
//     await Db.setDocData(collectionPath, docPath, data, true);
//   }

//   static Future updateCollectionData(
//     c1collectionPath,
//     c1docPath,
//     collectionPath,
//     docPath,
//     data,
//   ) async {
//     await Db.setC1DocData(
//         c1collectionPath, c1docPath, collectionPath, docPath, data, true);
//   }

//   static Future<List<Map<String, dynamic>>> readUserStoresData() async {
//     List<Map<String, dynamic>> userStoresData = [];

//     await Db.readC1AllData(
//             'users', AppInitialValue.userMobileNumber, 'yourStores')
//         .then((QuerySnapshot querySnapshot) {
//       if (querySnapshot.docs.isNotEmpty) {
//         for (var doc in querySnapshot.docs) {
//           for (int i = 0; i <= AppInitialValue.shops.length - 1; i++) {
//             if (AppInitialValue.shops[i]['mobileNumber'] == doc.id) {
//               userStoresData.add({
//                 "shopkeeperMobileNumber": doc.id,
//                 "payableAmount": doc['payableAmount'],
//                 "cart": doc['cart'] ?? {},
//                 "shopName": AppInitialValue.shops[i]['shopName'],
//                 'address': AppInitialValue.shops[i]['address'],
//                 'DelivaryRange': AppInitialValue.shops[i]['DelivaryRange'],
//                 'shopCategory': AppInitialValue.shops[i]['shopCategory'],
//                 'paymentQrcode': AppInitialValue.shops[i]['paymentQrcode'],
//               });
//               i = AppInitialValue.shops.length - 1;
//             }
//           }
//         }
//       }
//     });
//     return userStoresData;
//   }

//   static Future<void> addYourStore(id, name, context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(name),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Do you want to add this store in Your Stores?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//                 onPressed: () async {
//                   await MyDbFun.readUserData(
//                           AppInitialValue.userMobileNumber, 'yourStores', id)
//                       .then((value) async {
//                     if (value.isNotEmpty) {
//                       Navigator.pop(context);
//                       MyFun.showMyDialog(
//                           'Store is Already Added', false, context);
//                     } else {
//                       await Db.setC1DocData(
//                               'users',
//                               AppInitialValue.userMobileNumber,
//                               'yourStores',
//                               id,
//                               {'cart': {}, 'payableAmount': 0},
//                               true)
//                           .then((value) {
//                         Navigator.pop(context);
//                         MyFun.showMyDialog(
//                             'Store Added Successfully', false, context);
//                       });
//                     }
//                   });
//                 },
//                 child: const Text('Yes'))
//           ],
//         );
//       },
//     );
//   }
// }

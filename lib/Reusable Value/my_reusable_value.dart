import 'package:flutter/material.dart';

class MyUserDetails {
  static String mobileNumber = '';
  static String selectedRoll = "user";
  static String selectedShopCategory='';
  static Map userData = {'userType': 'shopkeeper'};
}

class MyUserPageDetails {
  static int currentIndex = 0;
  static Color color = Colors.green;
}

class MyItemsDetails{
 
}

class MyshopDetails{
  static String selectedShopCategory='All';
    static List shopItemsCategory = <String>[
    "Departmental",
    "Jewellery",
    "Medical",
    "Bakery",
    "Sweet",
    "Restaurant",
    "Dairy",
  ];
}
class MyReusableValue {
  static InputDecoration textBoxDecoration(String labelText, Widget icon) {
  return InputDecoration(
    prefixIcon: icon,
    labelText: labelText,
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    
  );
}
}

extension StringExtension on String {
  String capitalize() {
    return split(' ').map((word) => word.firstLetterCapitalize()).join(' ');
  }

  String firstLetterCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
ValueNotifier<int> badgeValue = ValueNotifier(0); 

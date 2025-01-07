import 'package:flutter/material.dart';

Widget mySearchItem(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500
      ),
      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Search Item'),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.qr_code_scanner_rounded),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
    ),
  );
}
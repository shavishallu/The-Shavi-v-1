import 'package:flutter/material.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';


class MyShopItemsCaterory extends StatefulWidget {
  const MyShopItemsCaterory(
      {super.key,
      required this.numberOfLoop,
      required this.categoryList,
      required this.refesh});
  final int numberOfLoop;
  final List categoryList;
  final Function refesh;

  @override
  State<MyShopItemsCaterory> createState() => _ShopItemsCateroryState();
}

class _ShopItemsCateroryState extends State<MyShopItemsCaterory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var i = 0; i <= widget.numberOfLoop - 1; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: InkWell(
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/${widget.categoryList[i]}.jpg'),
                          ),
                          border: Border.all(
                              color: MyshopDetails.selectedShopCategory ==
                                      widget.categoryList[i]
                                  ? Colors.green
                                  : Colors.black,
                              width: MyshopDetails.selectedShopCategory !=
                                      widget.categoryList[i]
                                  ? 0
                                  : 3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40.0))),
                    ),
                    SizedBox(
                        width: 82,
                        child: Text(
                          widget.categoryList[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyshopDetails.selectedShopCategory ==
                                      widget.categoryList[i]
                                  ? Colors.green
                                  : Colors.black,
                              fontWeight:
                                  MyshopDetails.selectedShopCategory ==
                                          widget.categoryList[i]
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              fontSize: 12),
                        )),
                  ],
                ),
                onTap: () {
                  setState(() {
                    MyshopDetails.selectedShopCategory =
                        widget.categoryList[i];
                    widget.refesh();
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

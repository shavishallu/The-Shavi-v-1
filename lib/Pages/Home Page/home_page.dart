import 'package:flutter/material.dart';
import 'package:the_shavi/Pages/Home%20Page/Shopkeeper%20Home%20Page/shopkeeper_homepage.dart';
import 'package:the_shavi/Pages/Test/test_page.dart';
import 'package:the_shavi/Reusable%20Function/reusable_funtion.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _userScreens = [
    const TestPage(),
    const TestPage(),
    const TestPage(),
    const TestPage(),
    const TestPage()
    // const UserHomePage(),
    // const UserAccountPage(),
    // const UserYourStoresPage(),
    // const UserAlartPage(),
    // const UserAlartPage(),
  ];
  final List<Widget> _shopkeeperScreens = [
    const ShopkeeperHomePage(),
    const TestPage(),
    const TestPage(),
    const TestPage(),
    const TestPage()
    // const ShopkeeperHomePage(),
    // const ShopkeeperAccount(),
    // const ShopkeeperStorePage(),
    // const ShopkeeperAlartPage(),
    // const UserAlartPage(),
  ];
  final List<Widget> _helperScreens = [
    const TestPage(),
    const TestPage(),
    const TestPage(),
    const TestPage(),
    const TestPage()
    // const UserAlartPage(),
    // const UserHomePage(),
    // const UserAccountPage(),
    // const UserYourStoresPage(),
    // const UserAlartPage(),
  ];

  final List<String> _userPageName = [
    'Home',
    'Account',
    'Your Stores',
    'Notifications',
    'Orders'
  ];
  final List<String> _shopkeeprPageName = [
    'Shopkeeper',
    'Account',
    'Your Shop',
    'Notifications',
    'Customers'
  ];
  final List<String> _helperPageName = [
    'Helper',
    'Account',
    'Your Stores',
    'Notifications',
    'Orders'
  ];
  final List<Icon> userIcon = [
    const Icon(
      Icons.home,
    ),
    const Icon(Icons.account_circle_outlined),
    const Icon(Icons.favorite),
    const Icon(Icons.notifications_active_outlined),
    const Icon(Icons.list_alt_outlined)
  ];
  final List<Icon> shopkeeperIcon = [
    const Icon(Icons.home),
    const Icon(Icons.account_circle_outlined),
    const Icon(Icons.storefront_outlined),
    const Icon(Icons.notifications_active_outlined),
    const Icon(Icons.people_alt_outlined)
  ];
  final List<Icon> heplerIcon = [
    const Icon(Icons.home),
    const Icon(Icons.account_circle_outlined),
    const Icon(Icons.favorite),
    const Icon(Icons.notifications_active_outlined),
    const Icon(Icons.list_alt_rounded)
  ];

  List<String> lable = ['', '', '', '', ''];
  List<Icon> icon = [
    const Icon(Icons.home),
    const Icon(Icons.home),
    const Icon(Icons.home),
    const Icon(Icons.home),
    const Icon(Icons.home),
  ];



  int _currentIndex = MyUserPageDetails.currentIndex;

  @override
  void initState() {
    // if (MyUserDetails.userData.isEmpty) {
    //   MyDbFun.checkUserExist(context);
    // }
     updateSelectedUser();
    // if (MyUserDetails.currentCameraPosition ==
    //     const CameraPosition(target: LatLng(20, 78), zoom: 3.7)) {
    //   getCurrentLocation().then((value) {
    //     MyUserDetails.currentCameraPosition = CameraPosition(
    //         target: LatLng(
    //           value.latitude,
    //           value.longitude,
    //         ),
    //         zoom: 15);
    //   }).then((value) {
    //     setState(() {});
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appbarHight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title:
            // MyUserDetails.userData.isEmpty
            //     ? const LinearProgressIndicator()
            //     :

            SizedBox(
          height: appbarHight - 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(MyFun.isWebOrRotate(context)) SizedBox(width: 68,),
              Image.asset("assets/shavilogo.png"),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: lable[_currentIndex] == 'Home' || MyFun.isWebOrRotate(context)
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          'assets/shavi.png',
                        ),
                      )
                    : Text(lable[_currentIndex]),
              ),
              if (MyUserDetails.userData['userType'] != 'user')
                availableUsersIcon('user', Icons.account_circle_outlined),
              if (MyUserDetails.userData['userType'] == 'shopkeeper')
                availableUsersIcon('shopkeeper', Icons.storefront),
              if (MyUserDetails.userData['userType'] == 'shopkeeper')
                availableUsersIcon('helper', Icons.man),
              if (MyUserDetails.userData['userType'] == 'helper')
                availableUsersIcon('helper', Icons.man),
            ],
          ),
        ),
        backgroundColor: MyUserPageDetails.color,

        // leading: Image.asset("assets/eSanjeevani.png"),
      ),
      bottomNavigationBar: MyFun.isWebOrRotate(context) == false
          ? BottomNavigationBar(
              selectedItemColor: MyUserPageDetails.color,
              currentIndex: _currentIndex,
              selectedFontSize: 12,
              unselectedFontSize: 10,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  MyUserPageDetails.currentIndex = _currentIndex;
                });
              },
              items: [
                for (int i = 0; i <= icon.length - 1; i++)
                  BottomNavigationBarItem(icon: icon[i], label: lable[i]),
              ],
            )
          : null,
      body:
          //  MyUserDetails.loading == true
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MyFun.isWebOrRotate(context))
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i <= icon.length - 1; i++)
                      ListTile(
                        leading: icon[i],
                        title: Text(lable[i],style: TextStyle(fontWeight: FontWeight.w600),),
                        selectedColor: MyUserPageDetails.color,
                        selectedTileColor: Colors.black12,
                      
                        selected: i == _currentIndex,
                        onTap: () {
                          setState(() {
                            _currentIndex = i;
                            MyUserPageDetails.currentIndex = _currentIndex;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          if (MyFun.isWebOrRotate(context))
            VerticalDivider(
              width: 2,
              color: MyUserPageDetails.color,
            ),
        
          Expanded(
            // flex: 6,
            child: selectedScreen(_currentIndex),
          ),
        ],
      ),
    );
  }

  updateSelectedUser() {
    setState(() {
      if (MyUserDetails.selectedRoll == "user") {
        lable = _userPageName;
        icon = userIcon;
        MyUserPageDetails.color = Colors.green;
      }
      if (MyUserDetails.selectedRoll == "shopkeeper") {
        lable = _shopkeeprPageName;
        icon = shopkeeperIcon;
        MyUserPageDetails.color = Colors.red;
      }
      if (MyUserDetails.selectedRoll == "helper") {
        lable = _helperPageName;
        icon = heplerIcon;
        MyUserPageDetails.color = Colors.black;
      }
    });
  }


  Widget selectedScreen(currentIndex) {
    if (MyUserDetails.selectedRoll == "user") {
      return _userScreens[currentIndex];
    }
    if (MyUserDetails.selectedRoll == "shopkeeper") {
      return _shopkeeperScreens[currentIndex];
    } else {
      return _helperScreens[currentIndex];
    }
  }
  Widget availableUsersIcon(String selectedRoll, IconData availIcon) {
    return InkWell(
        onTap: () {
          setState(() {
            MyUserDetails.selectedRoll = selectedRoll;
            updateSelectedUser();
            if (MyUserDetails.selectedRoll == 'shopkeeper') {
              // if (MyUserDetails.shopData['shopCategory']
              //         .contains(MyUserDetails.selectedShopCategory) ==
              //     false) {
              //   MyUserDetails.selectedShopCategory =
              //       MyUserDetails.shopData['shopCategory'][0];
              // }
            }
          });
        },
        child: Icon(
          availIcon,
          size: MyUserDetails.selectedRoll == selectedRoll ? 40 : 30,
          color: MyUserDetails.selectedRoll == selectedRoll
              ? Colors.white
              : Colors.grey,
        ));
  }

  loginPopUp(BuildContext context) {
    final TextEditingController mobileNumberController =
        TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: mobileNumberController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                    //   String username = mobileNumberController.text;
                    //   String password = passwordController.text;
                    //  print('Username: $username, Password: $password');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

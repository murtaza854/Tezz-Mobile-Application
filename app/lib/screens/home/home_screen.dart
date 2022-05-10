import 'package:app/responsive.dart';
import 'package:app/screens/emergencyContacts/components/mobile_emergency_contacts.dart';
import 'package:app/screens/home/components/mobile_home_screen.dart';
import 'package:app/screens/home/components/tablet_home_screen.dart';
import 'package:app/screens/profile/components/mobile_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../globals.dart' as globals;

import '../../constants.dart';
import '../../models/requests_model.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Widget activeTabMobile = const MobileHomeScreen();

  getRequests() {
    Stream<QuerySnapshot> requestsStream = FirebaseFirestore.instance
        .collection('requests')
        .where("receiver", isEqualTo: "${globals.user?.email}")
        .where("status", isEqualTo: false)
        .snapshots();

    requestsStream.listen((snapshot) {
      var requests = [];
      for (var doc in snapshot.docs) {
        requests.add(doc.data());
      }
      setState(() {
        globals.requests = requests;
      });
    });
  }

  getAcceptedRequests() {
    Stream<QuerySnapshot> requestsStream = FirebaseFirestore.instance
        .collection('requests')
        .where("sender", isEqualTo: "${globals.user?.email}")
        .where("status", isEqualTo: true)
        .where("seenAfterAcceptanceFrom", isEqualTo: false)
        .snapshots();

    requestsStream.listen((snapshot) {
      var requests = [];
      for (var doc in snapshot.docs) {
        requests.add(doc.data());
      }
      setState(() {
        globals.acceptedRequests = requests;
      });
    });
  }

  getSentRequests() {
    Stream<QuerySnapshot> requestsStream = FirebaseFirestore.instance
        .collection('requests')
        .where("sender", isEqualTo: "${globals.user?.email}")
        .snapshots();

    requestsStream.listen((snapshot) {
      // var requests = [];
      for (var doc in snapshot.docs) {
        // requests.add(doc.data());
        var element = RequestsModel.fromJson(doc.data());
        setState(() {
          globals.sentRequests[element.receiver] = element;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRequests();
    getAcceptedRequests();
    getSentRequests();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Responsive(
        mobile: activeTabMobile,
        tablet: const TabletHomeScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kTextColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: kLightColor,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/HomeScreen.png',
              width: getProportionateScreenWidth(30),
            ),
            icon: Image.asset(
              'assets/images/HomeScreen(G).png',
              width: getProportionateScreenWidth(30),
            ),
            label: 'Home',
          ),
          globals.requests.isNotEmpty
              ? BottomNavigationBarItem(
                  activeIcon: Stack(children: <Widget>[
                    Image.asset(
                      'assets/images/Contact.png',
                      width: getProportionateScreenWidth(30),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        constraints: BoxConstraints(
                          minWidth: getProportionateScreenWidth(20),
                          minHeight: getProportionateScreenWidth(20),
                        ),
                        child: Text(
                          "${globals.requests.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(13),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ]),
                  icon: Stack(children: <Widget>[
                    Image.asset(
                      'assets/images/Contact(G).png',
                      width: getProportionateScreenWidth(30),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        constraints: BoxConstraints(
                          minWidth: getProportionateScreenWidth(20),
                          minHeight: getProportionateScreenWidth(20),
                        ),
                        child: Text(
                          "${globals.requests.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(13),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ]),
                  label: 'Emergency Contacts',
                )
              : BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/images/Contact.png',
                    width: getProportionateScreenWidth(30),
                  ),
                  icon: Image.asset(
                    'assets/images/Contact(G).png',
                    width: getProportionateScreenWidth(30),
                  ),
                  label: 'Emergency Contacts',
                ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/Profile.png',
              width: getProportionateScreenWidth(30),
            ),
            icon: Image.asset(
              'assets/images/Profile(G).png',
              width: getProportionateScreenWidth(30),
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              activeTabMobile = const MobileHomeScreen();
            } else if (index == 1) {
              activeTabMobile = const MobileEmergencyContactsScreen();
            } else if (index == 2) {
              activeTabMobile = const MobileProfileScreen();
            }
          });
        },
      ),
    );
  }
}

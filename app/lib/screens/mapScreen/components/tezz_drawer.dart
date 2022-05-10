import 'package:app/constants.dart';
import 'package:app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../components/default_button.dart';

class TezzDrawer extends StatefulWidget {
  TezzDrawer({
    Key? key,
    required this.idleLocation,
    required this.currentLocationString,
    required this.ambulanceType,
    required this.ambulances,
    required this.changeActiveIndex,
    required this.chosenHospital,
  }) : super(key: key);

  final LatLng idleLocation;
  final String currentLocationString;
  final int ambulanceType;
  final List<dynamic> ambulances;
  final Function changeActiveIndex;
  var chosenHospital;

  @override
  State<TezzDrawer> createState() => _TezzDrawerState();
}

class _TezzDrawerState extends State<TezzDrawer> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(140),
                    vertical: getProportionateScreenHeight(20),
                  ),
                  child: Container(
                      height: getProportionateScreenHeight(5),
                      decoration: BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(10),
                    bottom: getProportionateScreenWidth(0),
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(20),
                    // vertical: getProportionateScreenWidth(5),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.near_me_outlined,
                          color: kPrimaryColor,
                          size: getProportionateScreenWidth(40),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Flexible(
                          child: Text(
                            widget.currentLocationString,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: getProportionateScreenWidth(18),
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(0),
                    bottom: getProportionateScreenWidth(0),
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(20),
                    // vertical: getProportionateScreenWidth(5),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_hospital_outlined,
                          color: kErrorColor,
                          size: getProportionateScreenWidth(40),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Flexible(
                          child: Text(
                            widget.ambulances[widget.ambulanceType]['name'],
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: getProportionateScreenWidth(18),
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(0),
                    bottom: getProportionateScreenWidth(20),
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(20),
                    // vertical: getProportionateScreenWidth(5),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          FontAwesome5.hospital,
                          color: kPrimaryColor,
                          size: getProportionateScreenWidth(40),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Flexible(
                          child: Text(
                            widget.chosenHospital['name'],
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: getProportionateScreenWidth(18),
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(50),
                    vertical: getProportionateScreenWidth(20),
                  ),
                  child: DefaultButton(
                    text: "Tezz",
                    press: () {
                      setState(() {
                        // widget.changeActiveIndex(3);
                      });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}

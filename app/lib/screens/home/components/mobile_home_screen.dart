import 'package:app/components/color_icon_button.dart';
import 'package:app/screens/home/components/pickup_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../globals.dart' as globals;

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    // Orientation _orientation = MediaQuery.of(context).orientation;
    // String name = globals.user?.firstName ?? '';
    // print(name);
    String name= globals.user?.getFirstName();
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(60)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: getProportionateScreenWidth(5)),
                  SizedBox(
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize:
                              getProportionateScreenWidth(kPhoneFontSizeTitle),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text: "Hello, ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                          TextSpan(
                              text: name,
                              style: const TextStyle(fontWeight: FontWeight.w100)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "Click the button below during emergencies",
                style: TextStyle(
                  fontSize: kPhoneFontSizeSubtitle,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              TextButton(
                onPressed: () {
                  // print("object");
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(100),
                        ),
                      );
                    },
                  ),
                  overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.withOpacity(0.5)),
                ),
                child: Image.asset(
                  'assets/images/SOS-Button.png',
                  width: getProportionateScreenWidth(190),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: const [
                    PickupForm(),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ColorIconButton(
                      iconFirst: true,
                      setIcon: Icons.medical_services_outlined,
                      color: kSecondaryColor,
                      topText: "       First-Aid",
                      bottomText: "      Tips"),
                  SizedBox(width: getProportionateScreenWidth(30)),
                  const ColorIconButton(
                      iconFirst: false,
                      setIcon: Icons.near_me_outlined,
                      color: kErrorColor,
                      topText: "SOS       ",
                      bottomText: "Message      "),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

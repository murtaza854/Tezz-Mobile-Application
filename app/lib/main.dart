import 'dart:convert';

import 'package:app/models/user_model.dart';
import 'package:app/routes.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:app/screens/medicalCardSetup/medical_card_setup_screen.dart';
import 'package:app/screens/onboarding/onboarding_screen.dart';
import 'package:app/screens/otpPhone/otp_phone_screen.dart';
// import 'package:app/screens/otp/otp_screen.dart';
// import 'package:app/screens/onboardingSignup/onboarding_signup_screen.dart';
// import 'package:app/screens/signin/signin_screen.dart';
// import 'package:app/screens/splash/splash_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // UserModel? user;
  // bool loading = true;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final String oneSignalAppId = "${dotenv.env['ONESIGNAL_APP_ID']}";

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//     //Remove this method to stop OneSignal Debugging
//     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//     OneSignal.shared.setAppId("7086fa4f-34ce-4502-965e-d70e077b2565");

// // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//       print("Accepted permission: $accepted");
//     });
    Widget home;
    if (globals.loading) {
      getLoggedInUser();
      home = const Scaffold();
    } else {
      if (globals.user != null) {
        if (globals.user?.hasPhoneNumber() != null) {
          if (globals.user?.accountSetup != false) {
            home = const MedicalCardSetup();
          } else {
            home = const HomeScreen();
          }
        } else {
          home = const OtpPhoneScreen();
        }
      } else {
        home = OnboardingScreen();
      }
    }
    print("user: ${globals.user}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tezz',
      theme: theme(),
      home: home,
      // home: const OnboardingScreen(),
      // initialRoute: initialRoute,
      // initialRoute: OtpScreen.routeName,
      // initialRoute: OtpPhoneScreen.routeName,
      // initialRoute: OnboardingSignupScreen.routeName,
      // initialRoute: SigninScreen.routeName,
      routes: routes,
    );
  }

  void getLoggedInUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    // await FirebaseAuth.instance.signOut();
    final response = await http.post(
        Uri.parse("${dotenv.env['API_URL1']}/user/get-logged-in-user"),
        // Uri.parse("${dotenv.env['API_URL2']}/user/get-logged-in-user"),
        // Uri.parse("${dotenv.env['API_URL3']}/user/get-logged-in-user"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${dotenv.env['API_KEY_BEARER']}"
        },
        body: jsonEncode({
          "uid": user?.uid,
        }));
    // await Future.delayed(const Duration(seconds: 1));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Setting External User Id with Callback Available in SDK Version 3.9.3+
      OneSignal.shared.setExternalUserId(data['_id']).then((results) {
        print(results.toString());
      }).catchError((error) {
        print(error.toString());
      });
      // var requestsCollection = FirebaseFirestore.instance
      //     .collection('requests')
      //     .where("receiver", isEqualTo: "${data['email']}")
      //     .where("status", isEqualTo: false);

      setState(() {
        globals.user = UserModel.fromJson(data);
        globals.loading = false;
      });
      // requestsCollection.get().then((snapshot) {
      //   var requests = snapshot.docs.map((doc) {
      //     return doc.data();
      //   }).toList();
      //   setState(() {
      //     globals.requests = requests;
      //   });
      // }).catchError((error) {
      //   print(error.toString());
      // });
      // var requestsSnapshot = await requestsCollection.get();
      // var requestsData = requestsSnapshot.docs;
      // var requests = requestsData.map((doc) {
      //   return doc.data();
      // }).toList();
      // data['requests'] = requests;
      // requestsCollection = FirebaseFirestore.instance
      //     .collection('requests')
      //     .where("sender", isEqualTo: "${data['email']}")
      //     .where("status", isEqualTo: true)
      //     .where("seenAfterAcceptanceFrom", isEqualTo: false);
      // requestsSnapshot = await requestsCollection.get();
      // requestsData = requestsSnapshot.docs;
      // requests = requestsData.map((doc) {
      //   return doc.data();
      // }).toList();
      // data['acceptedRequests'] = requests;
    } else {
      setState(() {
        globals.loading = false;
      });
    }
  }
}

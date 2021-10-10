import 'package:earn_miles/bottom_nav.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/providers/general_provider.dart';
import 'package:earn_miles/providers/transaction_provider.dart';
import 'package:earn_miles/screens/auth_screen.dart';
import 'package:earn_miles/screens/bills/my_bill.dart';
import 'package:earn_miles/screens/faq/faq.dart';
import 'package:earn_miles/screens/faq/faq_details.dart';
import 'package:earn_miles/screens/message_center/announcement_screen.dart';
import 'package:earn_miles/screens/message_center/message_center_screen.dart';

import 'package:earn_miles/screens/referral_screen.dart';
import 'package:earn_miles/screens/rental/my_solars.dart';
import 'package:earn_miles/screens/rental/rental_details.dart';
import 'package:earn_miles/screens/rental/rental_screen.dart';
import 'package:earn_miles/screens/settings/about_us.dart';
import 'package:earn_miles/screens/settings/change_password.dart';
import 'package:earn_miles/screens/settings/customer-service.dart';
import 'package:earn_miles/screens/settings/feedback_form.dart';
import 'package:earn_miles/screens/settings/forgot_password.dart';
import 'package:earn_miles/screens/settings/privacy_policy.dart';
import 'package:earn_miles/screens/settings/terms_of_service.dart';
import 'package:earn_miles/screens/transcations/deposit_record.dart';
import 'package:earn_miles/screens/transcations/deposit_screen.dart';
import 'package:earn_miles/screens/transcations/withdraw_screen.dart';
import 'package:earn_miles/screens/transcations/withdrawal_proofs.dart';
import 'package:earn_miles/screens/transcations/withdrawal_record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: TransactionProvider()),
        ChangeNotifierProvider.value(value: GeneralProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            textTheme: GoogleFonts.ptSansTextTheme()),
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          );
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) => snapshot.hasData ? MyNav() : AuthScreen(),
        ),
        routes: {
          MyNav.routeName: (context) => MyNav(),
          DepositScreen.routeName: (context) => DepositScreen(),
          WithdrawScreen.routeName: (context) => WithdrawScreen(),
          ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
          TermsofService.routeName: (context) => TermsofService(),
          PrivacyPolicy.routeName: (context) => PrivacyPolicy(),
          AboutUs.routeName: (context) => AboutUs(),
          FeedbackComplaintScreen.routeName: (context) =>
              FeedbackComplaintScreen(),
          MessageCenterScreen.routeName: (context) => MessageCenterScreen(),
          FAQ.routeName: (context) => FAQ(),
          WithdrawalProofs.routeName: (context) => WithdrawalProofs(),
          MyBill.routeName: (context) => MyBill(),
          DepositRecord.routeName: (context) => DepositRecord(),
          WithdrawRecord.routeName: (context) => WithdrawRecord(),
          RentalDetails.routeName: (context) => RentalDetails(),
          AuthScreen.routeName: (context) => AuthScreen(),
          RentalScreen.routeName: (context) => RentalScreen(),
          CustomerService.routeName: (context) => CustomerService(),
          AnnouncementScreen.routeName: (context) => AnnouncementScreen(),
          FaqDetails.routeName: (context) => FaqDetails(),
          MySolars.routeName: (context) => MySolars(),
          ForgotPassword.routeName: (context) => ForgotPassword(),
        },
      ),
    );
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print('LINK: ' + deepLink.path);

      Get.to(() => ReferralScreen(
            deepLink.path.replaceAll('/refer/', ''),
          ));
    } else {
      print('LINK NOT WORKING');
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print('LINK: ' + deepLink.path);

        Get.to(() => ReferralScreen(
              deepLink.path.replaceAll('/refer/', ''),
            ));
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }
}

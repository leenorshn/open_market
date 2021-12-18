import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kin_food/ui/screens/user/user_profile.dart';

import '../../../size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? _verificationId;

  late String name, phone, sms, codeDail;

  bool isProcessed = false;
  String _message = "";

  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1.0,
          title: Text("Login"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.translucent,
          child: SafeArea(
            child: new Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _verificationId == null
                        ? _newAccountWidgets(context)
                        : _phoneVerificationSms(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _newAccountWidgets(context) {
    return <Widget>[
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: "Kombxl",
            style: GoogleFonts.russoOne(
              fontSize: 4.1 * SizeConfig.textMultiplier,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "Direct\n",
            style: GoogleFonts.russoOne(
              fontSize: 4.1 * SizeConfig.textMultiplier,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: "Compte KombxlDirect",
            style: TextStyle(
              fontSize: 2.5 * SizeConfig.textMultiplier,
              color: Colors.blueGrey[900],
              fontWeight: FontWeight.w400,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        "Entrer votre numéro de téléphone pour commencer.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 2.3 * SizeConfig.textMultiplier,
            color: Colors.grey[700],
            fontWeight: FontWeight.w300),
      ),
      SizedBox(
        height: 48,
      ),

      Container(
        padding: EdgeInsets.only(left: 0, right: 16),
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _phoneController,
          onChanged: (value) {
            phone = value;
          },
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 8,
                right: 8,
              ),
              child: Text(
                "+243",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            border: InputBorder.none,
            labelText: "Téléphone",
            hintText: "Ex: 978563412",
            contentPadding: EdgeInsets.only(bottom: 10, left: 16),
            fillColor: Colors.white,
            filled: true,
            //suffixIcon: Icon(Icons.phone_android),
          ),
        ),
      ),
      SizedBox(
        height: 80,
      ),
      isProcessed
          ? CircularProgressIndicator()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
                primary: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                padding:
                    EdgeInsets.only(top: 14, bottom: 14, left: 56, right: 56),
              ),
              onPressed: () {
                if (_phoneController.text != '') {
                  _verifyPhoneNumber(context);
                } else {
                  _showErrorSnackBar(
                      messageError:
                          "Numèro invalide, véillez entrer un numèro valide pour se connecter",
                      context: context);
                }
              },
              child: Text("Continuer"),
            ),
      SizedBox(
        height: 20,
      ),

      SizedBox(
        height: 32,
      ),
      //GoogleLoginButton(),
    ];
  }

  _phoneVerificationSms(context) {
    return <Widget>[
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Kom",
              style: GoogleFonts.russoOne(
                fontSize: 4.1 * SizeConfig.textMultiplier,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "Brussels\n",
              style: GoogleFonts.russoOne(
                fontSize: 4.1 * SizeConfig.textMultiplier,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Text("Vérification du numéro",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )),
      SizedBox(
        height: 10,
      ),
      Text(
        "Vous allez récevoir un sms contenant un code de vérification du numéro ${getPhone(phone)}",
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: (value) {
            sms = value;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            labelText: "Code sms",
            labelStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(
              Icons.phone_android,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      isProcessed
          ? CircularProgressIndicator()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                primary: Theme.of(context).accentColor,
                padding: EdgeInsets.only(
                  top: 14,
                  bottom: 14,
                  left: 56,
                  right: 56,
                ),
              ),
              onPressed: () {
                _signInWithPhoneNumber();
              },
              child: Text("Vérifier"),
            ),
    ];
  }

  void _verifyPhoneNumber(context) async {
    setState(() {
      isProcessed = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: getPhone(_phoneController.text),
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          setState(() {
            isProcessed = false;
          });
        }
        //BlocProvider.of<AuthBloc>(context)..add(AuthStartedEvent());
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          _showErrorSnackBar(
              context: context, messageError: "Numéro incorrect");
          setState(() {
            isProcessed = false;
          });
        } else {
          _showErrorSnackBar(context: context, messageError: "${e.message}");
          setState(() {
            isProcessed = false;
          });
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          isProcessed = false;
        });
        print(_verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        print(_verificationId);
      },
    );
  }

  String getPhone(String phone) {
    if (phone.startsWith("0")) {
      return phone.replaceFirst("0", "+243");
    } else {
      if (phone.startsWith("+243")) {
        return phone;
      } else {
        return "+243" + phone;
      }
    }
  }

  void _signInWithPhoneNumber() async {
    setState(() {
      isProcessed = true;
    });

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: sms,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
        phoneAuthCredential,
      );

      setState(() {
        isProcessed = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserProfile(
                phone: phone,
                uid: userCredential.user!.uid,
              )));
    } on FirebaseAuthException {
      setState(() {
        _message = "inconnu";
      });
      _showErrorSnackBar(messageError: "$_message", context: context);
      return;
    }
  }

  _showErrorSnackBar({messageError, context}) {
    print(messageError);
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text("Erreur ${messageError.toString()}")),
          Icon(Icons.error),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

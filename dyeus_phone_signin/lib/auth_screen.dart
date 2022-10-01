import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

const double width = 160.0;
const double height = 45.0;
const double signinAlign = -1;
const double signUpAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black;

class _AuthScreenState extends State<AuthScreen> {
  late double xAlign;
  late Color signinColor;
  late Color signUpColor;

  @override
  void initState() {
    super.initState();
    xAlign = signinAlign;
    signinColor = selectedColor;
    signUpColor = normalColor;
  }

  String textHolder1 = 'Welcome Back!!';
  String textHolder2 = 'Please Login with your phone number';

  changeText1() {
    setState(() {
      textHolder1 = 'Welcome to App';
      textHolder2 = 'Please signup with your phone number to get registered';
    });
  }

  changeText2() {
    setState(() {
      textHolder1 = 'Welcome Back!!';
      textHolder2 = 'Please Login with your phone number';
    });
  }

  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  void signOutMe() async {
    await _auth.signOut();
  }

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCard = await _auth.signInWithCredential(phoneAuthCredential);
      if (authCard.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  showOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          'Enter OTP',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 27),
        Center(
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Enter your OTP',
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                verificationId: verificationID, smsCode: otpController.text);
            signInWithPhoneAuthCred(phoneAuthCredential);
          },
          child: Text('verify'),
        ),
        SizedBox(height: 20),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                alignment: Alignment(xAlign, 0),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  width: width * 0.5,
                                  height: height,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(203, 249, 121, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    xAlign = signinAlign;
                                    signinColor = selectedColor;
                                    signUpColor = normalColor;
                                    changeText2();
                                  });
                                },
                                child: Align(
                                  alignment: Alignment(-1, 0),
                                  child: Container(
                                    width: width * 0.5,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Signin',
                                      style: TextStyle(
                                        fontFamily: 'Cera Pro',
                                        fontSize: 14,
                                        color: signinColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    xAlign = signUpAlign;
                                    signUpColor = selectedColor;
                                    signinColor = normalColor;
                                    changeText1();
                                  });
                                },
                                child: Align(
                                  alignment: const Alignment(1, 0),
                                  child: Container(
                                    width: width * 0.5,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Signup',
                                      style: TextStyle(
                                        fontFamily: 'Cera Pro',
                                        fontSize: 14,
                                        color: signUpColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        Text(
                          '$textHolder1',
                          style: const TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: Text(
                            '$textHolder2',
                            style: const TextStyle(
                              fontFamily: 'Cera Pro',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.88,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              ClipRRect(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child:
                                      Image.asset('assets/images/india.webp'),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              const Text(
                                '91',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontFamily: 'Cera Pro',
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.black26,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Cera Pro',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.034),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.062,
                            child: ElevatedButton(
                              onPressed: () => () async {
                                await _auth.verifyPhoneNumber(
                                  phoneNumber: "+91$phoneController",
                                  verificationCompleted:
                                      (phoneAuthCredential) {},
                                  verificationFailed: (verificationFailed) {
                                    print(verificationFailed);
                                  },
                                  codeSent: (verificationId,
                                      forceResendingToken) async {
                                    setState(() {
                                      currentState =
                                          LoginScreen.SHOW_OTP_FORM_WIDGET;
                                      verificationID = verificationId;
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (verificationId) async {},
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(203, 249, 121, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cera Pro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 30.0, right: 20.0),
                                  child: Divider(
                                    thickness: 2,
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                              const Text(
                                'OR',
                                style: TextStyle(
                                  fontFamily: 'Cera Pro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 30.0),
                                  child: Divider(
                                    thickness: 2,
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.062,
                            child: ElevatedButton(
                              onPressed: () => print("it's pressed"),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.black12,
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(248, 254, 244, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    child: Image.asset(
                                        'assets/images/metamask.png'),
                                  ),
                                  const Text(
                                    " Connect to Metamask",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cera Pro',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.062,
                            child: ElevatedButton(
                              onPressed: () => print("it's pressed"),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.black12,
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(248, 254, 244, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    child:
                                        Image.asset('assets/images/google.png'),
                                  ),
                                  const Text(
                                    " Connect to Google",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cera Pro',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.062,
                            child: ElevatedButton(
                              onPressed: () => print("it's pressed"),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.black12,
                                ),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    child:
                                        Image.asset('assets/images/apple.jpeg'),
                                  ),
                                  const Text(
                                    "Connect to Apple",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cera Pro',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Dont have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cera Pro',
                                ),
                              ),
                              Text(
                                " Signup",
                                style: TextStyle(
                                  color: Color.fromRGBO(203, 249, 121, 1),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cera Pro',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : showOtpFormWidget(context),
    );
  }
}

enum LoginScreen {
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FORM_WIDGET,
}

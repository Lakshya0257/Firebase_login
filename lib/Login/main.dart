import 'package:country_calling_code_picker/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login_page/Login/decision_tree/decision.dart';
import 'package:login_page/Screen/Homepage.dart';
import 'package:login_page/button/Button.dart';
import 'package:login_page/text_field/Text_field.dart';
import 'package:login_page/themes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: MyTheme.light_theme(context),
      darkTheme: MyTheme.dark_theme(context),
      home: const decision(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool otp_screen = false;
  bool email_signup = false;
  static String verification = '';
  bool loading = false;
  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country.callingCode;
    });
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country.callingCode;
      });
    }
  }

  String email = '';
  String password = '';
  String _selectedCountry = '';
  late String phoneotp;
  String phonenumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Please enter your Phone or Email',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: MaterialIndicator(
                      color: Colors.yellow,
                      height: 6,
                      topLeftRadius: 8,
                      topRightRadius: 8,
                      horizontalPadding: 10,
                      tabPosition: TabPosition.bottom,
                    ),
                    tabs: const [
                      Tab(
                        text: 'Phone Number',
                      ),
                      Tab(
                        text: 'Email',
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .06,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .8,
                                height: MediaQuery.of(context).size.width * .15,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: otp_screen
                                            ? Text(
                                                _selectedCountry,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17),
                                              )
                                            : TextButton(
                                                onPressed: () {
                                                  _showCountryPicker();
                                                },
                                                child: Text(
                                                  _selectedCountry,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                )),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: otp_screen
                                            ? Text(phonenumber)
                                            : TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                onChanged: (value) {
                                                  phonenumber = value;
                                                },
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.phone,
                                                        color: Colors.grey),
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none,
                                                    labelText:
                                                        'Enter Phone Number'),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                              ),
                              otp_screen
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Text('Wrong number? '),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    otp_screen = false;
                                                  });
                                                },
                                                child: const Text(
                                                  'Change',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent),
                                                ))
                                          ],
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Enter OTP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 23),
                                            )),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "We've sent the code verification to your phone number",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 17),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: PinCodeTextField(
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                activeColor: Colors.yellow,
                                                inactiveColor: Colors.grey[350],
                                                selectedColor: Colors.yellow,
                                              ),
                                              appContext: context,
                                              length: 6,
                                              onChanged: (value) {
                                                phoneotp = value;
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Button(
                                            on_pressed: () async {
                                              setState((){
                                                loading=true;
                                              });
                                              try{
                                                PhoneAuthCredential credential =
                                                PhoneAuthProvider.credential(
                                                    verificationId:
                                                    verification,
                                                    smsCode: phoneotp);
                                                await FirebaseAuth.instance
                                                    .signInWithCredential(
                                                    credential);
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homepage()));
                                              }
                                              catch(e){print(e);}
                                              setState((){
                                                loading=false;
                                              });
                                            },
                                            text: 'Login'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'By clicking Login, you accept our',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const Text(
                                          'Terms & Conditions',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 20),
                                        )
                                      ],
                                    )
                                  : Button(
                                      on_pressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        await FirebaseAuth.instance
                                            .verifyPhoneNumber(
                                          timeout: const Duration(seconds: 60),
                                          phoneNumber:
                                              _selectedCountry + phonenumber,
                                          verificationCompleted:
                                              (PhoneAuthCredential
                                                  credential) async {},
                                          verificationFailed:
                                              (FirebaseAuthException e) {
                                            setState(() {
                                              loading = false;
                                            });
                                            if (e.code ==
                                                'invalid-phone-number') {
                                              print(phonenumber);
                                              print(
                                                  'The provided phone number is not valid.');
                                            }
                                          },
                                          codeSent: (String verificationId,
                                              int? resendToken) {
                                            verification = verificationId;
                                            setState(() {
                                              otp_screen = true;
                                              loading = false;
                                            });
                                          },
                                          codeAutoRetrievalTimeout:
                                              (String verificationId) {
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                        );
                                      },
                                      text: 'Send OTP'),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .06,
                              ),
                              Text_field(
                                text_field: TextField(
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.mail),
                                      border: InputBorder.none,
                                      labelText: email_signup
                                          ? 'Create new Mail Id'
                                          : 'Enter Mail Id'),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02,
                              ),
                              Text_field(
                                text_field: TextField(
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.security),
                                      border: InputBorder.none,
                                      labelText: email_signup
                                          ? 'Create new password'
                                          : 'Enter Password'),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                              email_signup
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text("Already have an account? "),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                email_signup = false;
                                              });
                                            },
                                            child: const Text("Log In ")),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text("Don't have an account? "),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                email_signup = true;
                                              });
                                            },
                                            child: const Text("Sign Up ")),
                                      ],
                                    ),
                              email_signup
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Button(
                                            on_pressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              try {
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                  email: email.toString(),
                                                  password: password.toString(),
                                                );
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homepage()));
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code == 'weak-password') {
                                                  print(
                                                      'The password provided is too weak.');
                                                } else if (e.code ==
                                                    'email-already-in-use') {
                                                  print(
                                                      'The account already exists for that email.');
                                                }
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                            },
                                            text: 'Signup'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'By clicking Signup, you accept our',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const Text(
                                          'Terms & Conditions',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 20),
                                        )
                                      ],
                                    )
                                  : Button(
                                      on_pressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        try {
                                           await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homepage()));
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            print(
                                                'No user found for that email.');
                                          } else if (e.code ==
                                              'wrong-password') {
                                            print(
                                                'Wrong password provided for that user.');
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      text: 'Login')
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        loading
            ? Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.white.withOpacity(.8),
                child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.black, size: 80)))
            : Container()
      ]),
    );
  }
}

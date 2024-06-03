import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../Firebase.dart';
import '../widgets/assets.dart';
import '../widgets/commonColor.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "نسيت كلمة المرور",
            style: TextStyle(color: CommonColor.calendarColor),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: CommonColor.calendarColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                padding: const EdgeInsets.all(0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 265,
                      width: 265,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: "#9DBA89".toHexa(),
                      ),
                      child: Image.asset(
                        Assets.shared.password,
                        height: 180,
                        width: 180,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "الرجاء إدخال عنوان البريد الإلكتروني",
                      style: TextStyle(
                        fontSize: 20,
                        color: "#9DBA89".toHexa(),
                      ),
                    ),
                    Text(
                      "الخاص بك للحصول على رمز التحقق.",
                      style: TextStyle(
                        fontSize: 20,
                        color: "#9DBA89".toHexa(),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Text(
                          "البريد الإلكتروني",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(
                                0.0,
                                5.0,
                              ),
                              blurRadius: 0.10,
                              spreadRadius: 0.10,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value.trim(),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "example@gmail.com",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        forgotPassword(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 170,
                        height: 44,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: "#DDE9BD".toHexa(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'ارسال',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: "#365133".toHexa(),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  forgotPassword(context) async {
    if (email != "") {
      if (!email.isValidEmail()) {
        _scaffoldKey.showTosta(context,
            message: "يرجى إدخال البريد الإلكتروني الصحيح", isError: true);
        return;
      }
      Firebase.shared.restUsers(email: email).then((value) async {
        if (value.isNotEmpty) {
          bool success = await Firebase.shared
              .forgotPassword(context, scaffoldKey: _scaffoldKey, email: email);
          if (success) {
            _scaffoldKey.showTosta(context,
                message: 'تم إرسال رابط نسيت كلمة السر إلى بريدك الإلكتروني');
          }
        } else {
          _scaffoldKey.showTosta(context,
              message: "يرجى إدخال البريد الإلكتروني الصحيح", isError: true);
        }
      });
    } else {
      _scaffoldKey.showTosta(context,
          message: 'الرجاء أدخال بريدك الإلكتروني', isError: true);
    }
  }
}

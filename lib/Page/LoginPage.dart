import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../Firebase.dart';
import '../Model/LoginModel.dart';
import '../Model/UserModel.dart';
import '../user_profile.dart';
import '../widgets/assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isShowPassword = true;
  bool mark = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            child: Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Stack(
                      children: [
                        Image.asset(
                          fit: BoxFit.cover,
                          Assets.shared.ellipse,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.shared.login3,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Assets.shared.login1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.shared.login2,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Stack(
                      children: [
//                        Image.asset(
//                           Assets.shared.vector,
//                           height: 21.88,
//                           width: 25,
//                         ),
                        Text(
                          "تسجيل دخول",
                          style: TextStyle(
                              color: "#365133".toHexa(), fontSize: 45),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.all(0),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "  البريد الالكتروني",
                            style: TextStyle(
                              color: "#365133".toHexa(),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 44,
                      width: 292,
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
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
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "EXAMPLE@GMAIL.COM",
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.all(0),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "  كلمة المرور",
                            style: TextStyle(
                              color: "#365133".toHexa(),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 44,
                      width: 292,
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
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
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        obscureText: isShowPassword,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "**************",
                          fillColor: Colors.grey[100],
                        ).copyWith(
                            suffixIcon: GestureDetector(
                          onTap: () => setState(() {
                            isShowPassword = !isShowPassword;
                          }),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: isShowPassword
                                  ? Icon( Icons.visibility_off_outlined,
                                      color: "#889D81".toHexa())
                                  : Icon(
                                Icons.visibility_outlined,
                                      color: "#889D81".toHexa(),
                                    )),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 320,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: "#889D81".toHexa(),
                                  side: BorderSide(
                                      width: 2, color: "#889D81".toHexa()),
                                  value: mark,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      mark = value!;
                                    });
                                    if (value == false) {
                                      SaveLogin.shared.setUser(user: null);
                                    }
                                  }),
                              Text(
                                "تذكرني",
                                style: TextStyle(
                                  color: "#889D81".toHexa(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                color: "#889D81".toHexa(),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () => Navigator.pushNamed(
                                context, '/ForgotPasswordPage'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        login();
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          'دخول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: "#365133".toHexa(),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70.01,
                          child: Divider(
                            color: "#9DBA89".toHexa(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("او"),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 70.01,
                          child: Divider(
                            color: "#9DBA89".toHexa(),
                          ),
                        )
                      ],
                    ),
                     const SizedBox(
                          height: 20,
                        ),
                   TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/RegisterPage'),
                            child: Text(
                              "التسجيل",
                              style: TextStyle(
                                  color: "#9DBA89".toHexa(), fontSize: 16),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "اذا كنت تعاني من مشكلة اضغط هنا",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/SupportPage'),
                        child: Text(
                          " مركز الدعم",
                          style: TextStyle(
                              color: "#9DBA89".toHexa(), fontSize: 16),
                        )),
                  ]))),
        ));
  }

  bool _validation() {
    return !(email.text == "" || password.text == "");
  }

  login() {
    if (!_validation()) {
      scaffoldKey.showTosta(context,
          message: 'يرجى تعبئة جميع الحقول', isError: true);
      return;
    }
    if (!email.text.isValidEmail()) {
      scaffoldKey.showTosta(context,
          message: "يرجى إدخال البريد الإلكتروني الصحيح", isError: true);
      return;
    }
    if (mark = true) {
      TextInput.finishAutofillContext();
      SaveLogin.shared.setUser(user: LoginModel(email: email.text, password: password.text, mark: mark));
      Firebase.shared.login(context, scaffoldKey: scaffoldKey, email: email.text, password: password.text);
    } else {
      Firebase.shared.login(context,
          scaffoldKey: scaffoldKey, email: email.text, password: password.text);
    }
  }

  remember() async {
    LoginModel? user = await SaveLogin.shared.getUser();
    if (user != null) {
      setState(() {
        mark = user.mark;
        email.text = user.email;
        password.text = user.password;
      });
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../Firebase.dart';
import '../Model/UserModel.dart';
import '../enum/status.dart';
import '../user_profile.dart';
import '../widgets/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String splash = 'first';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wrapper();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: splash == 'first',
                  child: Stack(
                    children: [
                      Image.asset(
                        fit: BoxFit.cover,
                        Assets.shared.plant11,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.asset(Assets.shared.plant),
                    ],
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: Stack(
                    children: [
                      Image.asset(
                        fit: BoxFit.cover,
                        Assets.shared.plant22,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.asset(Assets.shared.plant1),
                    ],
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: Stack(
                    children: [
                      Image.asset(
                        fit: BoxFit.cover,
                        Assets.shared.plant33,
                        width: MediaQuery.of(context).size.width,
                        height: 450,
                      ),
                      Image.asset(Assets.shared.plant2),
                    ],
                  )),
              Visibility(
                  visible: splash == 'first',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash != 'last',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            splash = 'first';
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: splash == 'first'
                                  ? "#365133".toHexa()
                                  : "#D1DFC8".toHexa(),
                              shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            splash = 'two';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: splash == 'two'
                                  ? "#365133".toHexa()
                                  : "#D1DFC8".toHexa(),
                              shape: BoxShape.circle),
                          height: 20,
                          width: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            splash = 'thre';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: splash == 'thre'
                                  ? "#365133".toHexa()
                                  : "#D1DFC8".toHexa(),
                              shape: BoxShape.circle),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  )),
              Visibility(
                  visible: splash == 'first',
                  child: Image.asset(Assets.shared.splash1)),
              Visibility(
                  visible: splash == 'two',
                  child: Image.asset(Assets.shared.splash2)),
              Visibility(
                  visible: splash == 'thre',
                  child: Image.asset(Assets.shared.splash3)),
              Visibility(
                  visible: splash == 'first',
                  child: const SizedBox(
                    height: 10,
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: const SizedBox(
                    height: 10,
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: const SizedBox(
                    height: 10,
                  )),
              Visibility(
                  visible: splash == 'first',
                  child: Text(
                    'تعرف على المزيد حول نباتاتك وكيفية \n الاعتناء بها',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: "#365133".toHexa(),
                    ),
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: Text(
                    'لمعرفة حالة نبتتك الجميلة و هل تعاني  \n من اي امراض ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: "#365133".toHexa(),
                    ),
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: Text(
                    'واكتشف معلومات اكتر عن التربة و حالتها \n و العديد من المزايا الاخرى ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: "#365133".toHexa(),
                    ),
                  )),
              Visibility(
                  visible: splash == 'first',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: const SizedBox(
                    height: 20,
                  )),
              Visibility(
                  visible: splash == 'first',
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        splash = 'two';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 350,
                      height: 77,
                      decoration: BoxDecoration(
                        color: "#D1DFC8".toHexa(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Text(
                        'التالي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )),
              Visibility(
                  visible: splash == 'two',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            splash = 'thre';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: 163,
                          height: 77,
                          decoration: BoxDecoration(
                            color: "#D1DFC8".toHexa(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: const Text(
                            'التالي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            splash = 'first';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: 163,
                          height: 77,
                          decoration: BoxDecoration(
                            color: "#D1DFC8".toHexa(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: const Text(
                            'رجوع',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Visibility(
                  visible: splash == 'thre',
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        splash = 'last';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 350,
                      height: 77,
                      decoration: BoxDecoration(
                        color: "#D1DFC8".toHexa(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Text(
                        'البدء',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )),
              Visibility(
                visible: splash == 'last',
                child: const SizedBox(
                  height: 50,
                ),
              ),
              Visibility(
                  visible: splash == 'last',
                  child: Image.asset(
                    Assets.shared.logo,
                    height: 228,
                    width: 376,
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: const SizedBox(
                    height: 50,
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/LoginPage'),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 168,
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
                          color: "#c7d5aa".toHexa(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Center(
                          child: Text(
                            'تسجيل الدخول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: const SizedBox(
                    height: 10,
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/RegisterPage'),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 168,
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
                        color: "#c2c3c0".toHexa(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: const Text(
                          'التسجيل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: const SizedBox(
                    height: 10,
                  )),
              Visibility(
                  visible: splash == 'last',
                  child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/start'),
                      child: Text(
                        'زائر',
                        style: TextStyle(color: "#5CA7ED".toHexa()),
                      ))),
            ],
          ),
        )),
        bottomNavigationBar: Visibility(
          visible: splash == 'last',
          child: Image.asset(
            Assets.shared.splash,
            height: 200,
            width: 278,
          ),
        ));
  }

  _wrapper() async {
    UserModel? user = await UserProfile.shared.getUser();
    if (user != null) {
      Firebase.shared.userByUid(uid: user.uid).then((user) {
        if (user.accountStatus == Status.active) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/HomePage", (route) => false,
              arguments: user.userType);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/LoginPage", (route) => false);
        }
      });
    } else {
      //   Navigator.of(context).pushNamedAndRemoveUntil("/LoginPage", (route) => false);
    }
  }
}

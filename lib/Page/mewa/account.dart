import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/enum/Usertype.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:file_selector/file_selector.dart';
import '../../Firebase.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool isShowPassword = false;
  String name = '';
  String last = '';
  String certificate = '';
  String email = '';
  String phone = '';
  String? cv = '';
  String years = '';
  String address = '';
  String city = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.backgroundAccount,
                  width: MediaQuery.of(context).size.width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      Assets.shared.login2,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, top: 120),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Text(
                        "اضافة حساب",
                        style:
                            TextStyle(color: "#365133".toHexa(), fontSize: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 290,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "الاسم الاول",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => name = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "ادخل اسمك",
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8), // Added this
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "الاسم الاخير",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => last = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "ادخل اسمك",
                            contentPadding: EdgeInsets.all(8),
                            // Added this
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                    "  الشهادة ",
                    style: TextStyle(
                      color: "#365133".toHexa(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 292,
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) => certificate = value.trim(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "بكالوريوس علوم زراعية ",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(8), // Added this
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    "  البريد الالكتروني ",
                    style: TextStyle(
                      color: "#365133".toHexa(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 292,
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) => email = value.trim(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "ادخل بريدك الالكتروني ",
                  contentPadding: EdgeInsets.all(8),
                  // Added this
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    "  رقم الجوال",
                    style: TextStyle(
                      color: "#365133".toHexa(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 292,
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) => phone = value.trim(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "رقم الجوال ",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(8), // Added this
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 290,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "السيرة الذاتية",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          onChanged: (value) => cv = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "pdf",
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8), // Added this
                          ).copyWith(
                              suffixIcon: GestureDetector(
                            onTap: () {
                              upload(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  size: 20,
                                  Icons.upload,
                                  color: "#365133".toHexa(),
                                )),
                          )),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "سنوات الخبرة",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => years = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "5 سنوات",
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8), // Added this
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 290,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "المدينة",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => city = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(8),
                            // Added this
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "المدينة المنورة ",
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "العنوان",
                        style: TextStyle(
                          color: "#365133".toHexa(),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: 137,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => address = value.trim(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "البدراني",
                            contentPadding: EdgeInsets.all(8),
                            // Added this
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                    "  كلمة السر المؤقتة ",
                    style: TextStyle(
                      color: "#365133".toHexa(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 292,
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                textInputAction: TextInputAction.done,
                obscureText: isShowPassword,
                onChanged: (value) => password = value.trim(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "*****************",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(8), // Added this
                ).copyWith(
                    suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    isShowPassword = !isShowPassword;
                  }),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: isShowPassword
                          ? Icon(Icons.visibility_off_outlined,
                              color: "#889D81".toHexa())
                          : Icon(
                              Icons.visibility_outlined,
                              color: "#889D81".toHexa(),
                            )),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (!email.isValidEmail()) {
                      scaffoldKey.showTosta(context,
                          message: "يرجى إدخال البريد الإلكتروني الصحيح",
                          isError: true);
                      return;
                    }
                    if (!password.isValidPassword()) {
                      scaffoldKey.showTosta(context,
                          message: "يجب ان يكون الرقم السري 8 احرف او ارقام",
                          isError: true);
                      return;
                    }
                    if (!specialist()) {
                      scaffoldKey.showTosta(context,
                          message: 'يرجى تعبئة جميع الحقول', isError: true);
                      return;
                    }
                    Firebase.shared.createAccount(context,
                        scaffoldKey: scaffoldKey,
                        name: name,
                        last: last,
                        email: email,
                        address: address,
                        city: city,
                        phone: phone,
                        password: password,
                        experience: '',
                        certificate: certificate,
                        years: years,
                        cv: cv!,
                        userType: Usertype.specialist,
                        status: Status.active);
                    setState(() {
                      name == "" ;
                          last == "" ;
                          email == "" ;
                          address == "" ;
                          city == "" ;
                          phone == "" ;
                          password == "" ;
                          certificate == "" ;
                          years == "" ;
                          cv == "";
                    });
                  },
                  child: Container(
                    height: 22,
                    width: 64,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            blurRadius: 0.10,
                            spreadRadius: 0.10,
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        border: Border.all(
                          color: "#c7d5aa".toHexa(),
                        )),
                    child: Text(
                      'حفظ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: "#c7d5aa".toHexa()),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 22,
                    width: 64,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            blurRadius: 0.10,
                            spreadRadius: 0.10,
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        border: Border.all(color: Colors.red)),
                    child: const Text(
                      'الغاء',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ),
                )
              ],
            )
          ])),
    ));
  }

  bool specialist() {
    return !(name == "" ||
        last == "" ||
        email == "" ||
        address == "" ||
        city == "" ||
        phone == "" ||
        password == "" ||
        certificate == "" ||
        years == "" ||
        cv == "");
  }

  upload(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      cv = await Firebase.shared.upload(
          folderName: email, pdfName: file.name, file: XFile('${file.path}'));
      scaffoldKey.showTosta(context,
          message: 'تم تحديد ملف السيرة الذاتية', isError: false);
    } else {
      scaffoldKey.showTosta(context,
          message: 'يرجى تحديد ملف السيرة الذاتية', isError: true);
    }
  }
}

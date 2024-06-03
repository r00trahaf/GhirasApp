import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../Firebase.dart';
import '../enum/Usertype.dart';
import '../enum/status.dart';
import '../widgets/assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String name = '';
  String last = '';
  String email = '';
  String address = '';
  String city = '';
  String phone = '';
  String confirm = '';
  String password = '';
  String experience = '';
  String certificate = '';
  String years = '';
  String? cv = '';

  bool isShowPassword = true;
  Usertype userType = Usertype.user;
  Status status = Status.active;

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
                    Stack(
                      children: [
//                        Image.asset(
//                           Assets.shared.vector,
//                           height: 21.88,
//                           width: 25,
//                         ),
                        Text(
                          "جديد هنا؟",
                          style: TextStyle(
                              color: "#365133".toHexa(), fontSize: 60),
                        ),
                      ],
                    ),
                    const Text(
                      "انضم الينا",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 44,
                      width: 250,
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: "#E2ECC7".toHexa(),
                            disabledColor: "#E2ECC7".toHexa(),
                            showCheckmark: false,
                            label: const Text(
                              "اصحاب النباتات",
                            ),
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: "#365133".toHexa(),
                            ),
                            shape: ContinuousRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            selected: userType == Usertype.user,
                            onSelected: (selected) {
                              setState(() {
                                userType = Usertype.user;
                              });
                            },
                          ),
                          ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: "#E2ECC7".toHexa(),
                            disabledColor: "#E2ECC7".toHexa(),
                            shape: ContinuousRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            showCheckmark: false,
                            label: const Text("اخصائي النباتات"),
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: "#365133".toHexa(),
                            ),
                            selected: userType == Usertype.specialist,
                            onSelected: (selected) {
                              setState(() {
                                userType = Usertype.specialist;
                              });
                            },
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
                                "الاسم الاول",
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                height: 37,
                                width: 137,
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "ادخل اسمك",
                                    fillColor: Colors.white,
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
                                height: 37,
                                width: 137,
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "ادخل اسمك",
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
                          borderRadius: BorderRadius.circular(20)),
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
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 290,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "الشهادة",
                                  style: TextStyle(
                                    color: "#365133".toHexa(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) =>
                                        certificate = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "بكالوريوس علوم زراعية",
                                      fillColor: Colors.white,
                                    ),
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
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => years = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "5 سنوات",
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                        visible: userType == Usertype.specialist,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 300,
                          ),
                          padding: const EdgeInsets.all(0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "  الخبرات",
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Visibility(
                        visible: userType == Usertype.specialist,
                        child: Container(
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
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            onChanged: (value) => experience = value.trim(),
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
                              hintText:
                                  "زراعة المحاصيل، وإجراء أعمال الصيانة في المزرعة",
                              fillColor: Colors.white,
                            ),
                          ),
                        )),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 290,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "رقم الجوال",
                                  style: TextStyle(
                                    color: "#365133".toHexa(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => phone = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "********05 ",
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  height: 37,
                                  width: 137,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "pdf",
                                      fillColor: Colors.white,
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
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: Container(
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
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => city = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
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
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) =>
                                        address = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "البدراني",
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 290,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "كلمة المرور",
                                  style: TextStyle(
                                    color: "#365133".toHexa(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    obscureText: isShowPassword,
                                    onChanged: (value) =>
                                        password = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "***************** ",
                                      fillColor: Colors.white,
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
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "تاكيد كلمة المرور",
                                  style: TextStyle(
                                    color: "#365133".toHexa(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.done,
                                    obscureText: isShowPassword,
                                    onChanged: (value) =>
                                        confirm = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "*****************",
                                      fillColor: Colors.white,
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.specialist,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: userType == Usertype.user,
                      child: Container(
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
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => city = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
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
                                  height: 37,
                                  width: 137,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) =>
                                        address = value.trim(),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "البدراني",
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: const SizedBox(
                          height: 20,
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
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
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
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
                              borderRadius: BorderRadius.circular(20)),
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
                              hintText: "********05",
                              fillColor: Colors.white,
                            ),
                          ),
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: const SizedBox(
                          height: 20,
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
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
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
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
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            textInputAction: TextInputAction.next,
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
                              hintText: "**************",
                              fillColor: Colors.white,
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
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: const SizedBox(
                          height: 20,
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 300,
                          ),
                          padding: const EdgeInsets.all(0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "  تاكيد كلمة المرور",
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: Container(
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
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            obscureText: isShowPassword,
                            onChanged: (value) => confirm = value.trim(),
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
                              hintText: "**************",
                              fillColor: Colors.white,
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
                        )),
                    Visibility(
                        visible: userType == Usertype.user,
                        child: const SizedBox(
                          height: 10,
                        )),
                    InkWell(
                      onTap: () {
                        register(context);
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
                          'سجل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: "#365133".toHexa(),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/LoginPage'),
                      child: Text("هل لديك حساب ؟ اضغط هنا",
                          style: TextStyle(
                              color: "#365133".toHexa(), fontSize: 16)),
                    ),
                  ])),
        )));
  }

  bool user() {
    return !(name == "" ||
        last == "" ||
        email == "" ||
        address == "" ||
        city == "" ||
        phone == "" ||
        password == "");
  }

  bool specialist() {
    return !(name == "" ||
        last == "" ||
        email == "" ||
        address == "" ||
        city == "" ||
        phone == "" ||
        password == "" ||
        experience == "" ||
        certificate == "" ||
        years == "" ||
        cv == "");
  }

  register(context) {
    if (userType == Usertype.user) {
      if (!user()) {
        scaffoldKey.showTosta(context,
            message: 'يرجى تعبئة جميع الحقول', isError: true);
        return;
      }
      if (!email.isValidEmail()) {
        scaffoldKey.showTosta(context,
            message: "يرجى إدخال البريد الإلكتروني الصحيح", isError: true);
        return;
      }
      if (!password.isValidPassword()) {
        scaffoldKey.showTosta(context,
            message: "يجب ان يكون الرقم السري 8 احرف او ارقام", isError: true);
        return;
      }
      if (password != confirm) {
        scaffoldKey.showTosta(context,
            message: "كلمه المرور غير متطابقه", isError: true);
        return;
      }


      setState(() {
        status = Status.active;
      });

      Firebase.shared.createAccountUser(context,
          scaffoldKey: scaffoldKey,
          name: name,
          last: last,
          email: email,
          address: address,
          city: city,
          phone: phone,
          password: password,
          experience: experience,
          certificate: certificate,
          years: years,
          cv: cv!,
          userType: userType,
          status: status);
    } else {
      if (!specialist()) {
        scaffoldKey.showTosta(context,
            message: 'يرجى تعبئة جميع الحقول', isError: true);
        return;
      }
      if (!email.isValidEmail()) {
        scaffoldKey.showTosta(context,
            message: "يرجى إدخال البريد الإلكتروني الصحيح", isError: true);
        return;
      }
      if (!password.isValidPassword()) {
        scaffoldKey.showTosta(context,
            message: "يجب ان يكون الرقم السري 8 احرف او ارقام", isError: true);
        return;
      }
      if (password != confirm) {
        scaffoldKey.showTosta(context,
            message: "كلمه المرور غير متطابقه", isError: true);
        return;
      }

      setState(() {
        status = Status.pending;
      });

      Firebase.shared.createAccountUser(context,
          scaffoldKey: scaffoldKey,
          name: name,
          last: last,
          email: email,
          address: address,
          city: city,
          phone: phone,
          password: password,
          experience: experience,
          certificate: certificate,
          years: years,
          cv: cv!,
          userType: userType,
          status: status);
    }
  }

  upload(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      cv = await Firebase.shared.upload(folderName: email, pdfName: file.name, file: XFile('${file.path}'));
      scaffoldKey.showTosta(context, message: 'تم تحديد ملف السيرة الذاتية', isError: false);
    } else {
      scaffoldKey.showTosta(context,
          message: 'يرجى تحديد ملف السيرة الذاتية', isError: true);
    }
  }
}

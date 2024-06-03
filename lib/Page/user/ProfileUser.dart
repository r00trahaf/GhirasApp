import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:image_picker/image_picker.dart';
import '../../Firebase.dart';
import '../../Model/UserModel.dart';
import '../../enum/status.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  File? _imagePerson;
  String logo = '';
  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

 bool edit = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: Firebase.shared.userByUid(uid: Firebase.shared.auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? user = snapshot.data;
            name.text = user!.name;
            last.text = user.last;
            email.text = user.email;
            phone.text = user.phone;
            address.text = user.address;
            city.text = user.city;
            return SingleChildScrollView(
                child: Center(
              child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                      children: [
                        Visibility(
                          visible: edit,
                            child: Stack(
                          children: [
                            Image.asset(
                              fit: BoxFit.cover,
                              Assets.shared.profileUser,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.only(top: 155),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Center(
                                    child: Text(
                                      user.id,
                                      style: TextStyle(
                                          color: "#9f9f9f".toHexa(), fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "الاسم الاول",
                                    style: TextStyle(
                                      color: "#8c8c8c".toHexa(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
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
                                        borderRadius: BorderRadius.circular(20)),
                                    child: TextField(
                                      textInputAction: TextInputAction.next,
                                      controller: name,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                        hintText: "ادخل اسمك",
                                        contentPadding: EdgeInsets.all(8),
                                        prefixIcon: Image.asset(
                                          Assets.shared.profilePage,
                                        ),
                                        // Added this
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "الاسم الاخير",
                                    style: TextStyle(
                                      color: "#8c8c8c".toHexa(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
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
                                    ], borderRadius: BorderRadius.circular(20)),
                                    child: TextField(
                                      textInputAction: TextInputAction.next,
                                      controller: last,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                        hintText: "ادخل اسمك",
                                        contentPadding: EdgeInsets.all(8),
                                        prefixIcon: Image.asset(
                                          Assets.shared.profilePage,
                                        ),
                                        // Added this
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "  رقم الجوال",
                                    style: TextStyle(
                                      color: "#8c8c8c".toHexa(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
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
                                      controller: phone,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                        prefixIcon: Image.asset(
                                          Assets.shared.tel,
                                        ),
                                        hintText: "رقم الجوال ",
                                        fillColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.all(8), // Added this
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "  البريد الالكتروني ",
                                    style: TextStyle(
                                      color: "#8c8c8c".toHexa(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
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
                                      controller: email,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.calendarColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                        hintText: "ادخل بريدك الالكتروني ",
                                        contentPadding: EdgeInsets.all(8),
                                        // Added this
                                        fillColor: Colors.white,
                                        prefixIcon: Image.asset(
                                          Assets.shared.email,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "    المدينة",
                                              style: TextStyle(
                                                color: "#8c8c8c".toHexa(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              width: 161,
                                              height: 50,
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
                                                  BorderRadius.circular(20)),
                                              child: TextField(
                                                textInputAction:
                                                TextInputAction.next,
                                                controller: city,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  filled: true,
                                                  contentPadding: EdgeInsets.all(8),
                                                  // Added this
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: "المدينة المنورة ",
                                                  fillColor: Colors.white,
                                                  prefixIcon: Image.asset(
                                                    Assets.shared.vectorCity,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "    العنوان",
                                              style: TextStyle(
                                                color: "#8c8c8c".toHexa(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              width: 161,
                                              height: 50,
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
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              child: TextField(
                                                textInputAction:
                                                TextInputAction.done,
                                                controller: address,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      CommonColor.calendarColor,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: "البدراني",
                                                  contentPadding:
                                                  const EdgeInsets.all(8),
                                                  prefixIcon: Image.asset(
                                                    Assets.shared.vectorCity,
                                                  ),
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
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 130,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: "#D9D9D9".toHexa(),
                                                offset: const Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                                blurRadius: 0.10,
                                                spreadRadius: 0.10,
                                              ),
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: "#c7d5aa".toHexa(),
                                            )),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  surfaceTintColor: Colors.white,
                                                  backgroundColor: Colors.white,
                                                  title: Text(
                                                    "تغيير كلمة المرور",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: "#688665".toHexa(),
                                                    ),
                                                  ),
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller: password,
                                                          textAlign:
                                                          TextAlign.center,
                                                          cursorColor: Colors.black,
                                                          keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                          textInputAction:
                                                          TextInputAction.done,
                                                          decoration:
                                                          InputDecoration(
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            border:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            contentPadding:
                                                            EdgeInsets.all(8),
                                                            // Added this
                                                            hintText:
                                                            'كلمة المرور القديمة ',
                                                            labelText:
                                                            'كلمة المرور القديمة ',
                                                            labelStyle:
                                                            const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller: confirm,
                                                          textAlign:
                                                          TextAlign.center,
                                                          cursorColor: Colors.black,
                                                          keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                          textInputAction:
                                                          TextInputAction.next,
                                                          decoration:
                                                          InputDecoration(
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            border:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            contentPadding:
                                                            EdgeInsets.all(8),
                                                            // Added this
                                                            hintText:
                                                            'كلمة المرور الجديدة ',
                                                            labelText:
                                                            'كلمة المرور الجديدة ',
                                                            labelStyle:
                                                            const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          textAlign:
                                                          TextAlign.center,
                                                          cursorColor: Colors.black,
                                                          keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                          textInputAction:
                                                          TextInputAction.done,
                                                          controller:
                                                          confirmPassword,
                                                          decoration:
                                                          InputDecoration(
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            border:
                                                            OutlineInputBorder(
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            contentPadding:
                                                            EdgeInsets.all(8),
                                                            hintText:
                                                            'تاكيد كلمة المرور الجديدة ',
                                                            labelText:
                                                            'تاكيد كلمة المرور الجديدة ',
                                                            labelStyle:
                                                            const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (!confirm.text
                                                                .isValidPassword()) {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                  "يجب ان يكون الرقم السري 8 احرف او ارقام",
                                                                  isError: true);
                                                              return;
                                                            }
                                                            if (confirm.text !=
                                                                confirmPassword
                                                                    .text) {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                  "يجب ان يكون الرقم السري متطابقين",
                                                                  isError: true);
                                                              return;
                                                            }
                                                            if (password.text !=
                                                                user.password) {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                  "يجب ان يكون الرقم السري صحيحه القديمه",
                                                                  isError: true);
                                                              return;
                                                            }
                                                            Firebase.shared
                                                                .changePassword(
                                                                context,
                                                                scaffoldKey:
                                                                scaffoldKey,
                                                                newPassword:
                                                                confirm
                                                                    .text,
                                                                confirmPassword:
                                                                confirmPassword
                                                                    .text);
                                                          },
                                                          child: Container(
                                                            height: 22,
                                                            width: 64,
                                                            decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        20)),
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                Border.all(
                                                                  color: "#c7d5aa"
                                                                      .toHexa(),
                                                                )),
                                                            child: Text(
                                                              'حفظ',
                                                              textAlign:
                                                              TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: "#c7d5aa"
                                                                      .toHexa()),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            height: 22,
                                                            width: 64,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    20)),
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red)),
                                                            child: const InkWell(
                                                              child: Text(
                                                                'الغاء',
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color:
                                                                    Colors.red),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'تغيير كلمة المرور',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: "#c7d5aa".toHexa()),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 130,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: "#D9D9D9".toHexa(),
                                                offset: const Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                                blurRadius: 0.10,
                                                spreadRadius: 0.10,
                                              ),
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: "#c7d5aa".toHexa(),
                                            )),
                                        child: InkWell(
                                          onTap: () {
                                            Firebase.shared.updateAccountUser(
                                                context,
                                                scaffoldKey: scaffoldKey,
                                                name: name.text,
                                                last: last.text,
                                                email: email.text,
                                                address: address.text,
                                                city: city.text,
                                                phone: phone.text,
                                                password: user.password,
                                                experience: user.experience,
                                                certificate: user.certificate,
                                                years: user.years,
                                                cv: user.cv,
                                                userId: user.uid,
                                                userType: user.userType,
                                                status: user.accountStatus,
                                                section: user.section,
                                                image: user.image, );
                                          },
                                          child: Text(
                                            'حفظ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: "#c7d5aa".toHexa()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 130,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: "#D9D9D9".toHexa(),
                                                offset: const Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                                blurRadius: 0.10,
                                                spreadRadius: 0.10,
                                              ),
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: "#c7d5aa".toHexa(),
                                            )),
                                        child: InkWell(
                                          onTap: () {
                                            Firebase.shared.signOut(context);
                                          },
                                          child: Text(
                                            'تسجيل خروج',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: "#c7d5aa".toHexa()),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 130,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: "#D9D9D9".toHexa(),
                                                offset: const Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                                blurRadius: 0.10,
                                                spreadRadius: 0.10,
                                              ),
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.red,
                                            )),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  surfaceTintColor: Colors.white,
                                                  backgroundColor: Colors.white,
                                                  title: Text(
                                                    " هل انت متاكد من حذف حسابك؟",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: "#688665".toHexa(),
                                                    ),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Firebase.shared
                                                                .deleteAccountUser(
                                                                context,
                                                                scaffoldKey:
                                                                scaffoldKey,
                                                                name: name.text,
                                                                last: last.text,
                                                                email:
                                                                email.text,
                                                                address: user
                                                                    .address,
                                                                city: user.city,
                                                                phone:
                                                                phone.text,
                                                                password: user
                                                                    .password,
                                                                experience: user
                                                                    .experience,
                                                                certificate: user
                                                                    .certificate,
                                                                years:
                                                                user.years,
                                                                cv: user.cv,
                                                                userId:
                                                                user.uid,
                                                                userType: user
                                                                    .userType,
                                                                status: Status
                                                                    .pending,
                                                                section: user
                                                                    .section,
                                                                image:
                                                                user.image, );
                                                            Firebase.shared
                                                                .signOut(context);
                                                          },
                                                          child: Container(
                                                            height: 22,
                                                            width: 64,
                                                            decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        20)),
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                Border.all(
                                                                  color: Colors
                                                                      .red,
                                                                )),
                                                            child: const Text(
                                                              'حذف',
                                                              textAlign:
                                                              TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color:
                                                                  Colors.red),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            height: 22,
                                                            width: 64,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    20)),
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                    color: "#9DBA89"
                                                                        .toHexa())),
                                                            child: Text(
                                                              'الغاء',
                                                              textAlign:
                                                              TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: "#9DBA89"
                                                                      .toHexa()),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'حذف الحساب',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.red),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 100),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: _imagePerson != null
                                      ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(_imagePerson!),
                                            fit: BoxFit.cover)),
                                  )
                                      : user.image != ""
                                      ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                            NetworkImage(user.image),
                                            fit: BoxFit.cover)),
                                  )
                                      : Icon(
                                    Icons.person,
                                    size: 52,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 510,
                              right: 130,
                              child: Container(
                                height: 22,
                                width: 64,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: "#c7d5aa".toHexa(),
                                    )),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      edit = false;
                                      logo = user.image;
                                    });
                                  },
                                  child: const Text(
                                    'تعديل',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        ),
                        Visibility(
                            visible: edit == false,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 80),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                      child: _imagePerson != null
                                          ? Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: FileImage(_imagePerson!),
                                                fit: BoxFit.cover)),
                                      ): user.image != ""
                                          ? Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(logo!),
                                                fit: BoxFit.cover)),
                                      )
                                          : Icon(
                                        Icons.person,
                                        size: 52,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F496profile?alt=media&token=3b07b96e-7f2f-4b6e-bf75-4ed600a750c9';
                                        });
                                      },
                                     child: Image.asset(Assets.shared.ProfileLogo,),),
                                   InkWell(
                                     onTap: () async {
                                       setState(() {
                                         logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F242profile?alt=media&token=9cc84026-9c89-4427-8e0f-0bbe60b32345';
                                       });
                                     },
                                     child: Image.asset(Assets.shared.ProfileLogo1,),),
                                   InkWell(
                                     onTap: () async {
                                       setState(() {
                                         logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F420profile?alt=media&token=571d57f2-7a15-4779-8a65-3fd08bf20400';
                                       });
                                     },
                                     child: Image.asset(Assets.shared.ProfileLogo2,),),
                                 ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F536profile?alt=media&token=217fcfdc-fb91-4279-a4c6-b9cd5ec67e89';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo3,),),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F415profile?alt=media&token=4ccfdb7a-ebf7-40c8-8282-f47c77a9e8e8';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo4,),),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F302profile?alt=media&token=5125df05-e98b-4f33-8028-898c0cc94de4';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo5,),),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F147profile?alt=media&token=8a61b726-27f5-44e7-bda6-49ef0114af71';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo6,),),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F226profile?alt=media&token=67383478-d238-49d0-906a-be501732adfa';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo7,),),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          logo = 'https://firebasestorage.googleapis.com/v0/b/gras-a42a7.appspot.com/o/profile%2F590profile?alt=media&token=712cebea-7e44-4d0b-80df-465e96eccd24';
                                        });
                                      },
                                      child: Image.asset(Assets.shared.ProfileLogo8,),),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  width: 329,
                                  height: 47,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CommonColor.calendarLightColor),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    color: CommonColor.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset:
                                        const Offset(
                                            0, 3),
                                      )
                                    ],
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => upload(context, type: ImageSource.gallery),
                                          child: textWidget(
                                            fontFamily:
                                            AppDetails.cairoRegular,
                                            fontSize: 15,
                                            color: "#365133"
                                                .toHexa(),
                                            text:
                                            "اختر من البوم الصور",
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        VerticalDivider(
                                          color: CommonColor.calendarLightColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(width: 50,),
                                        InkWell(
                                          onTap: () => upload(context, type: ImageSource.camera),
                                          child: textWidget(
                                            fontFamily:
                                            AppDetails
                                                .cairoRegular,
                                            text:
                                            "تصوير",
                                            fontSize: 15,
                                            color: "#365133"
                                                .toHexa(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  width: 70,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: "#D9D9D9".toHexa(),
                                          offset: const Offset(
                                            0.0,
                                            4.0,
                                          ),
                                          blurRadius: 0.10,
                                          spreadRadius: 0.10,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: "#c7d5aa".toHexa(),
                                      )),
                                  child: InkWell(
                                    onTap: () {
                                      Firebase.shared.updateAccountUser(
                                          context,
                                          scaffoldKey: scaffoldKey,
                                          name: name.text,
                                          last: last.text,
                                          email: email.text,
                                          address: address.text,
                                          city: city.text,
                                          phone: phone.text,
                                          password: user.password,
                                          experience: user.experience,
                                          certificate: user.certificate,
                                          years: user.years,
                                          cv: user.cv,
                                          userId: user.uid,
                                          userType: user.userType,
                                          status: user.accountStatus,
                                          section: user.section,
                                          image: logo, );
                                      setState(() {
                                        edit = true;
                                      });
                                    },
                                    child: Text(
                                      'حفظ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: "#c7d5aa".toHexa()),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                  ])),
            ));
          } else {
            return const SizedBox();
          }
        });
  }

  upload(context, {required ImageSource type}) async {
    PickedFile? image = await ImagePicker.platform.pickImage(source: type);
    if (image != null) {
      setState(() {
        _imagePerson = File(image.path);
      });
      logo = (await Firebase.shared.uploadPhoto(folderName: email.text, img: name.text, file: _imagePerson!))!;
      if (kDebugMode) {
        print(logo);
      }
      scaffoldKey.showTosta(context, message: 'تم تحديد ملف صورة', isError: false);
    } else {
      scaffoldKey.showTosta(context, message: 'يرجى تحديد صورة', isError: true);
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Firebase.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 80),
                        margin: const EdgeInsets.only(top: 140),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 350,
                                ),
                                child: FutureBuilder<List<UserModel>>(
                                    future: Firebase.shared.users(status: Status.pending, type: Usertype.specialist),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<UserModel> user = snapshot.data!;
                                        return Wrap(
                                            children: List.generate(
                                              user.length,
                                                  (index) {
                                                return Card(
                                                    elevation: 4,
                                                    surfaceTintColor: Colors.white,
                                                    color: Colors.white,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                      side: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                      AlignmentDirectional.centerEnd,
                                                      children: [
                                                        ListTile(
                                                          leading: CircleAvatar(
                                                            radius: 30.0,
                                                            child: user[index].image != ""
                                                                ? Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                      NetworkImage(user[index].image),
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
                                                          title: Text("${user[index].name} ${user[index].last}"),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(user[index].city),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 10, right: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.end,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return SingleChildScrollView (
                                                                            child:AlertDialog(
                                                                              surfaceTintColor:
                                                                              Colors.white,
                                                                              backgroundColor:
                                                                              Colors.white,
                                                                              title: Image.asset(
                                                                                Assets.shared.cancel,
                                                                                height: 100,
                                                                                width: 100,
                                                                              ),
                                                                              content:  Column(
                                                                                children: [
                                                                                  const Text(
                                                                                    "سيتم ارسال رساله رفض طلب انشاء حساب اخصائي نبات عبر البريد الالكتروني الرجاء كتابة السبب",
                                                                                    textAlign:
                                                                                    TextAlign.center,
                                                                                    style:
                                                                                    TextStyle(fontSize: 18),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height:
                                                                                    10,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    controller: text,
                                                                                    textAlign: TextAlign.center,
                                                                                    cursorColor:
                                                                                    Colors.black,
                                                                                    keyboardType:
                                                                                    TextInputType.text,
                                                                                    textInputAction:
                                                                                    TextInputAction.done,
                                                                                    decoration:
                                                                                    InputDecoration(
                                                                                      contentPadding:
                                                                                      const EdgeInsets.symmetric(vertical: 40),
                                                                                      // <-- SEE HERE
                                                                                      focusedBorder:
                                                                                      OutlineInputBorder(
                                                                                        borderSide: const BorderSide(
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(25.0),
                                                                                      ),
                                                                                      enabledBorder:
                                                                                      OutlineInputBorder(
                                                                                        borderSide: const BorderSide(
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(25.0),
                                                                                      ),
                                                                                      border:
                                                                                      OutlineInputBorder(
                                                                                        borderSide: const BorderSide(
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(25.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              actions: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap:
                                                                                          () async {
                                                                                        if (text.text == '') {
                                                                                          scaffoldKey.showTosta(context,
                                                                                              message: 'يرجى تعبئة جميع الحقول', isError: true);
                                                                                          return;
                                                                                        }

                                                                                        final response = await http.post(
                                                                                            Uri.parse('https://52be-2001-16a4-226-c58d-bc1f-77b5-b3fe-91fc.ngrok-free.app/gras-a42a7/us-central1/sendMail?dest=${user[index].email}'),
                                                                                            body: {
                                                                                              'subject': 'رفض طلب انشاء حساب اخصائي نبات',
                                                                                              'html': text.text,
                                                                                            });
                                                                                        log(response.body);
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 22,
                                                                                        width: 64,
                                                                                        decoration: BoxDecoration(
                                                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                            color: Colors.white,
                                                                                            border: Border.all(
                                                                                              color: Colors.grey,
                                                                                            )),
                                                                                        child:
                                                                                        const Text(
                                                                                          'ارسال',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap:
                                                                                          () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child:
                                                                                      Container(
                                                                                        height:
                                                                                        22,
                                                                                        width:
                                                                                        64,
                                                                                        decoration: BoxDecoration(
                                                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                            color: Colors.white,
                                                                                            border: Border.all(color: Colors.grey)),
                                                                                        child:
                                                                                        const InkWell(
                                                                                          child: Text(
                                                                                            'الغاء',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(fontSize: 15, color: Colors.grey),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ) ,
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Image.asset(
                                                                      Assets
                                                                          .shared.decline,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return AlertDialog(
                                                                            surfaceTintColor: Colors.white,
                                                                            backgroundColor: Colors.white,
                                                                            title: Image.asset(
                                                                              Assets
                                                                                  .shared
                                                                                  .approve,
                                                                            ),
                                                                            content: const Text(
                                                                              "سيتم ارسال رساله قبول الطلب عبر البريد الالكتروني",
                                                                              textAlign:
                                                                              TextAlign
                                                                                  .center,
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  18),
                                                                            ),
                                                                            actions: [
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap:
                                                                                        () async {
                                                                                      Firebase.shared.updateAccountUser(context,
                                                                                          scaffoldKey: scaffoldKey,
                                                                                          name: user[index].name,
                                                                                          last: user[index].last,
                                                                                          email: user[index].email,
                                                                                          address: user[index].address,
                                                                                          city: user[index].city,
                                                                                          phone: user[index].phone,
                                                                                          password: user[index].password,
                                                                                          experience: user[index].experience,
                                                                                          certificate: user[index].certificate,
                                                                                          years: user[index].years,
                                                                                          cv: user[index].cv,
                                                                                          userId: user[index].uid,
                                                                                          userType: user[index].userType,
                                                                                          status: Status.active,
                                                                                          section: user[index].section,
                                                                                          image: user[index].image, );
                                                                                          Navigator.of(context).pop();

                                                                                      final response = await http.post(
                                                                                          Uri.parse('https://52be-2001-16a4-226-c58d-bc1f-77b5-b3fe-91fc.ngrok-free.app/gras-a42a7/us-central1/sendMail?dest=${user[index].email}'),
                                                                                          body: {
                                                                                            'subject': 'قبول طلب انشاء حساب اخصائي نبات',
                                                                                            'html': "شكرا",
                                                                                          });
                                                                                      log(response.body);
                                                                                    },
                                                                                    child:
                                                                                    Container(
                                                                                      height: 22,
                                                                                      width: 64,
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                          color: Colors.white,
                                                                                          border: Border.all(
                                                                                            color: Colors.grey,
                                                                                          )),
                                                                                      child:
                                                                                      const Text(
                                                                                        'ارسال',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap:
                                                                                        () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child:
                                                                                    Container(
                                                                                      height:
                                                                                      22,
                                                                                      width:
                                                                                      64,
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                          color: Colors.white,
                                                                                          border: Border.all(color: Colors.grey)),
                                                                                      child:
                                                                                      const InkWell(
                                                                                        child: Text(
                                                                                          'الغاء',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(fontSize: 15, color: Colors.grey),
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
                                                                    child: Image.asset(
                                                                      Assets
                                                                          .shared.checked,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext
                                                                    context) {
                                                                      return AlertDialog(
                                                                        surfaceTintColor:
                                                                        Colors.white,
                                                                        backgroundColor:
                                                                        Colors.white,
                                                                        title: Text(
                                                                          'معلومات الاخصائي',
                                                                          textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                        ),
                                                                        content:
                                                                        SingleChildScrollView(
                                                                          child: Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        "الاسم الاول ",
                                                                                        style: TextStyle(
                                                                                          color: "#365133".toHexa(),
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].name,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        "الاسم الاخير ",
                                                                                        style: TextStyle(
                                                                                          color: "#365133".toHexa(),
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].last,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                10,
                                                                              ),
                                                                              Text(
                                                                                "البريد الالكتروني",
                                                                                style:
                                                                                TextStyle(
                                                                                  color: "#365133"
                                                                                      .toHexa(),
                                                                                  fontWeight:
                                                                                  FontWeight.bold,
                                                                                  fontSize:
                                                                                  12,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width:
                                                                                285,
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
                                                                                    color: Colors
                                                                                        .white,
                                                                                    borderRadius:
                                                                                    BorderRadius.circular(20)),
                                                                                child:
                                                                                Text(
                                                                                  user[index]
                                                                                      .email,
                                                                                  textAlign:
                                                                                  TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                10,
                                                                              ),
                                                                              Row(
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
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].certificate,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        "سنوات الخبرة ",
                                                                                        style: TextStyle(
                                                                                          color: "#365133".toHexa(),
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].experience,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                10,
                                                                              ),
                                                                              Text(
                                                                                "رقم الجوال",
                                                                                style:
                                                                                TextStyle(
                                                                                  color: "#365133"
                                                                                      .toHexa(),
                                                                                  fontWeight:
                                                                                  FontWeight.bold,
                                                                                  fontSize:
                                                                                  12,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width:
                                                                                285,
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
                                                                                    color: Colors
                                                                                        .white,
                                                                                    borderRadius:
                                                                                    BorderRadius.circular(20)),
                                                                                child:
                                                                                Text(
                                                                                  user[index]
                                                                                      .phone,
                                                                                  textAlign:
                                                                                  TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                10,
                                                                              ),
                                                                              Row(
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
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].city,
                                                                                          textAlign: TextAlign.center,
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
                                                                                        width: 130,
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
                                                                                        child: Text(
                                                                                          user[index].address,
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                10,
                                                                              ),
                                                                              Text(
                                                                                "السيرة الذاتية",
                                                                                style:
                                                                                TextStyle(
                                                                                  color: "#365133"
                                                                                      .toHexa(),
                                                                                  fontWeight:
                                                                                  FontWeight.bold,
                                                                                  fontSize:
                                                                                  12,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width:
                                                                                130,
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
                                                                                    color: Colors
                                                                                        .white,
                                                                                    borderRadius:
                                                                                    BorderRadius.circular(20)),
                                                                                child: IconButton(
                                                                                    onPressed:
                                                                                        () {
                                                                                          openUrl(link: user[index].cv);
                                                                                        },
                                                                                    icon:
                                                                                    Icon(CupertinoIcons.down_arrow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap:
                                                                                    () {
                                                                                  Navigator.of(context)
                                                                                      .pop();
                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  height:
                                                                                  22,
                                                                                  width:
                                                                                  64,
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius:
                                                                                      const BorderRadius.all(Radius.circular(20)),
                                                                                      color: Colors.white,
                                                                                      border: Border.all(color: Colors.grey)),
                                                                                  child:
                                                                                  const InkWell(
                                                                                    child:
                                                                                    Text(
                                                                                      'انتهاء',
                                                                                      textAlign:
                                                                                      TextAlign.center,
                                                                                      style:
                                                                                      TextStyle(fontSize: 15, color: Colors.grey),
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
                                                                child: Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: "#D1DFC8"
                                                                        .toHexa(),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        30)),
                                                                  ),
                                                                  width: 91,
                                                                  child: const Text(
                                                                    'المعلومات',
                                                                    textAlign:
                                                                    TextAlign.center,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                              },
                                            ));
                                      } else {
                                        return const SizedBox();
                                      }
                                    }))
                          ],
                        )),
                    Image.asset(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      Assets.shared.backgroundPending,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 93,
                        margin: const EdgeInsets.only(top: 80),
                        decoration: const BoxDecoration(
                          boxShadow: [
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'الطلبات',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
        ));
  }

  void openUrl({required String link}) {
    final Uri uri = Uri.parse(link);
    launchUrl(uri);
  }
}

import 'package:file_selector/file_selector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../../Firebase.dart';
import '../../Model/ReviewsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';
import 'dart:io';

class specialist_users extends StatefulWidget {
  const specialist_users({super.key});

  @override
  State<specialist_users> createState() => _specialist_usersState();
}

class _specialist_usersState extends State<specialist_users> {

  bool edit = false;
  String logo = '';
  String uid = '';
  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController cv = TextEditingController();
  TextEditingController certificate = TextEditingController();
  TextEditingController years = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Stack(
              children: [
              Image.asset(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                Assets.shared.specialistSplash,
              ),
              Container(
                margin:edit == false ? const EdgeInsets.only(top: 80):const EdgeInsets.only(top: 80),
                padding: edit == false ? const EdgeInsets.only(top: 0):const EdgeInsets.only(top: 80),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: edit == false ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          " أخصائي النبات",
                          style: TextStyle(
                              color: "#365133".toHexa(), fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                        ),
                        child: FutureBuilder<List<UserModel>>(
                            future: Firebase.shared.users(status: Status.active, type: Usertype.specialist),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<UserModel>? items = snapshot.data;
                                return Wrap(
                                    children: List.generate(
                                   items!.length,
                                  (index) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          edit = true;
                                          uid = items[index].uid;
                                          logo = items[index].image;
                                        });
                                      },
                                      child:  Card(
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
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: items[index].image != ""
                                                  ? Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(items[index].image),
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
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text("${items[index].name} ${items[index].last}"),
                                                Text(items[index].city),
                                                FutureBuilder<List<ReviewsModel>>(
                                                    future: Firebase.shared.reviews(uid: items[index].uid),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<ReviewsModel>
                                                        reviews =
                                                        snapshot.data!;
                                                        for (var user
                                                        in snapshot.data!) {
                                                          print(user.review);
                                                        }
                                                        return RatingBarIndicator(
                                                          itemSize: 15,
                                                          rating: reviews.length.toDouble(),
                                                          itemCount: 5,
                                                          itemBuilder:
                                                              (context, _) =>
                                                              Image.asset(
                                                                Assets.shared.rose,
                                                              ),
                                                        );
                                                      } else {
                                                        return RatingBarIndicator(
                                                          itemSize: 15,
                                                          rating: 0,
                                                          itemCount: 5,
                                                          itemBuilder:
                                                              (context, _) =>
                                                              Image.asset(
                                                                Assets.shared.rose,
                                                              ),
                                                        );
                                                      }
                                                    }),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ));
                              } else {
                                return const SizedBox(
                                  height: 300,
                                );
                              }
                            }))
                  ],
                ) :
                FutureBuilder<UserModel>(
                    future: Firebase.shared.userByUid(uid: uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserModel? user = snapshot.data;
                        name.text = user!.name;
                        last.text = user.last;
                        email.text = user.email;
                        phone.text = user.phone;
                        address.text = user.address;
                        cv.text = user.cv;
                        certificate.text = user.certificate;
                        years.text = user.years;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${user.name} ${user.last}',
                              style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 20),
                            ),
                            Text(
                              user.city,
                              style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 290,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:name,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            hintText: "ادخل اسمك",
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsets.all(
                                                8), // Added this
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:last,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            hintText: "ادخل اسمك",
                                            contentPadding:
                                            EdgeInsets.all(8),
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
                                mainAxisAlignment:
                                MainAxisAlignment.start,
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
                                textInputAction: TextInputAction.next,
                                controller:certificate,
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
                                  hintText: "بكالوريوس علوم زراعية ",
                                  fillColor: Colors.white,
                                  contentPadding:
                                  EdgeInsets.all(8), // Added this
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
                                mainAxisAlignment:
                                MainAxisAlignment.start,
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
                                textInputAction: TextInputAction.next,
                                controller:email,
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
                                mainAxisAlignment:
                                MainAxisAlignment.start,
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
                                textInputAction: TextInputAction.next,
                                controller:phone,
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
                                  hintText: "رقم الجوال ",
                                  fillColor: Colors.white,
                                  contentPadding:
                                  EdgeInsets.all(8), // Added this
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          onTap: (){},
                                          textInputAction:
                                          TextInputAction.next,
                                          readOnly: true,
                                          controller:cv,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            hintText: "pdf",
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsets.all(
                                                8), // Added this
                                          ).copyWith(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                uploadcv(context);
                                                },
                                                child: Container(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        10),
                                                    child: Icon(
                                                      size: 20,
                                                      Icons.upload,
                                                      color:
                                                      "#365133".toHexa(),
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:years,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            hintText: "5 سنوات",
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsets.all(
                                                8), // Added this
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:city,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            contentPadding:
                                            EdgeInsets.all(8),
                                            // Added this
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
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
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: TextField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:address,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            hintText: "البدراني",
                                            contentPadding:
                                            const EdgeInsets.all(8),
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
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
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
                                      borderRadius:
                                      const BorderRadius.all(
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
                                          certificate: certificate.text,
                                          years: years.text,
                                          cv: cv.text,
                                          userId: user.uid,
                                          userType: user.userType,
                                          status: user.accountStatus,
                                          section: user.section,
                                          image: user.image,);
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
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
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: "#c7d5aa".toHexa(),
                                      )),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        edit = false;
                                      });
                                    },
                                    child: Text(
                                      'اغلاق',
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
                                      borderRadius:
                                      const BorderRadius.all(
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
                                            surfaceTintColor:
                                            Colors.white,
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
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Firebase.shared.deleteAccountUser(
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
                                                          .signOut(
                                                          context);
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      width: 64,
                                                      decoration:
                                                      BoxDecoration(
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                          color: Colors
                                                              .white,
                                                          border:
                                                          Border
                                                              .all(
                                                            color: Colors
                                                                .red,
                                                          )),
                                                      child: const Text(
                                                        'حذف',
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .red),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(
                                                          context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      width: 64,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                          color: Colors
                                                              .white,
                                                          border: Border.all(
                                                              color: "#9DBA89"
                                                                  .toHexa())),
                                                      child: Text(
                                                        'الغاء',
                                                        textAlign:
                                                        TextAlign
                                                            .center,
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
                                          fontSize: 15,
                                          color: Colors.red),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox(
                          height: 300,
                        );
                      }
                    }),
              ),
              Visibility(
                visible: edit,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: logo != ""
                          ? Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                NetworkImage(logo),
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
                ),)
              ]
          )
        )
    );
  }

  uploadcv(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      cv.text = (await Firebase.shared.upload(folderName: email.text, pdfName: file.name, file: XFile('${file.path}')))!;
      scaffoldKey.showTosta(context, message: 'تم تحديد ملف السيرة الذاتية', isError: false);
    } else {
      scaffoldKey.showTosta(context,
          message: 'يرجى تحديد ملف السيرة الذاتية', isError: true);
    }
  }
}

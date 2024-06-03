import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Firebase.dart';
import '../../Model/ReviewsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usersmewa.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  CarouselController buttonCarouselController = CarouselController();

  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cv = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController certificate = TextEditingController();
  File? _imagePerson;
  String logo = '';
  TextEditingController years = TextEditingController();
  TextEditingController section = TextEditingController();
  Usertype selection = Usertype.specialist;

  bool edit = false;
  bool reviews = false;
  bool isShowPassword = true;
  String uid = '';
  String img = '';
  userReviews page = userReviews.home;

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == userReviews.home) {
      return home(context);
    } else if (page == userReviews.reviews) {
      return review(context);
    }
  }

  @override
  Widget home(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(children: [
            Container(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                margin: const EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: edit == false
                    ? FutureBuilder<List<UserModel>>(
                        future: Firebase.shared.users(
                            status: Status.active, type: Usertype.specialist),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child: user[index].image != ""
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      user[index]
                                                                          .image),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        )
                                                      : Icon(
                                                          Icons.person,
                                                          size: 52,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                ),
                                                title: Text(
                                                    "${user[index].name} ${user[index].last}"),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    edit = true;
                                                    name.text = user[index].name;
                                                    last.text =
                                                        user[index].last;
                                                    email.text =
                                                        user[index].email;
                                                    address.text =
                                                        user[index].address;
                                                    city.text =
                                                        user[index].city;
                                                    phone.text =
                                                        user[index].phone;
                                                    password.text =
                                                        user[index].password;
                                                    experience.text =
                                                        user[index].experience;
                                                    certificate.text =
                                                        user[index].certificate;
                                                    years.text =
                                                        user[index].years;
                                                    cv.text = user[index].cv;
                                                    section.text =
                                                        user[index].section;
                                                    userId.text =
                                                        user[index].uid;
                                                    selection =
                                                        user[index].userType;
                                                    logo = user[index].image;
                                                  });
                                                },
                                                child: Image.asset(
                                                  Assets.shared.write,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "     التقييم: ",
                                              ),
                                              FutureBuilder<List<ReviewsModel>>(
                                                  future: Firebase.shared
                                                      .reviews(
                                                          uid: user[index].uid),
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
                                                        rating: reviews.length
                                                            .toDouble(),
                                                        itemCount: 5,
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Image.asset(
                                                          Assets
                                                              .shared.flowerImg,
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
                                                  })
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "     الوصف: مهندس زراعي ",
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    page = userReviews.reviews;
                                                    uid = user[index].uid;
                                                    img = user[index].image;
                                                    name.text = user[index].name;
                                                    last.text = user[index].last;
                                                    address.text = user[index].address;
                                                    city.text = user[index].city;
                                                  });
                                                },
                                                child: Image.asset(
                                                  Assets.shared.bild,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ));
                          } else {
                            return const SizedBox();
                          }
                        })
                    : Column(
                        children: [
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: name,
                                        textInputAction: TextInputAction.next,
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: last,
                                        textInputAction: TextInputAction.next,
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
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
                              controller: certificate,
                              textInputAction: TextInputAction.next,
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
                              controller: email,
                              textInputAction: TextInputAction.next,
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
                              controller: phone,
                              textInputAction: TextInputAction.next,
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: cv,
                                        textInputAction: TextInputAction.next,
                                        readOnly: true,
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
                                          hintText: "pdf",
                                          fillColor: Colors.white,
                                        ).copyWith(
                                            suffixIcon: GestureDetector(
                                          onTap: () {
                                            print(cv.text);
                                            openUrl(link: cv.text);
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: experience,
                                        textInputAction: TextInputAction.next,
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: city,
                                        textInputAction: TextInputAction.next,
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: address,
                                        textInputAction: TextInputAction.next,
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
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
                              controller: password,
                              textInputAction: TextInputAction.done,
                              obscureText: isShowPassword,
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
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Firebase.shared.updateAccountUser(context,
                                      scaffoldKey: scaffoldKey,
                                      name: name.text,
                                      last: last.text,
                                      email: email.text,
                                      address: address.text,
                                      city: city.text,
                                      phone: phone.text,
                                      password: password.text,
                                      experience: experience.text,
                                      certificate: certificate.text,
                                      years: years.text,
                                      cv: cv.text,
                                      userId: userId.text,
                                      userType: selection,
                                      status: Status.active,
                                      section: section.text,
                                      image: logo, );
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: "#c7d5aa".toHexa(),
                                      )),
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
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    edit = false;
                                    name.text = '';
                                    last.text = '';
                                    email.text = '';
                                    address.text = '';
                                    city.text = '';
                                    phone.text = '';
                                    password.text = '';
                                    experience.text = '';
                                    certificate.text = '';
                                    cv.text = '';
                                    userId.text = '';
                                    logo = '';
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.red)),
                                  child: Text(
                                    'الغاء',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Firebase.shared.deleteAccountUser(context,
                                      scaffoldKey: scaffoldKey,
                                      name: name.text,
                                      last: last.text,
                                      email: email.text,
                                      address: address.text,
                                      city: city.text,
                                      phone: phone.text,
                                      password: password.text,
                                      experience: experience.text,
                                      certificate: certificate.text,
                                      years: years.text,
                                      cv: cv.text,
                                      userId: userId.text,
                                      userType: selection,
                                      status: Status.cancel,
                                      section: section.text,
                                      image: logo, );
                                  setState(() {
                                    edit = false;
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.red)),
                                  child: Text(
                                    'حذف الحساب',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      )),
            Image.asset(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              false == edit
                  ? Assets.shared.backgroundPending
                  : Assets.shared.backgroundRectangle,
            ),
            edit == false
                ? Center(
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
                              2.0,
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
                            '  أخصائي النبات',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 70, left: 20),
                        child: const Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Text('  أخصائي النبات',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 70, left: 20),
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
                              : logo != ""
                                  ? Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(logo),
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
                    ],
                  )
          ])),
    ));
  }

  Widget review(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(

              children: [
            Container(
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                margin: const EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(child:
                        Container(
                            margin: const EdgeInsets.only(top: 30),
                            width: 345,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#f3f3f3".toHexa(),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Column(
                                  children: [

                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text('${name.text} ${last.text}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: "#365133".toHexa(),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '${address.text } ${city.text}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: "#365133".toHexa(),
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                  ],
                                )
                            )),),
                        Center(child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child:CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: img != ""
                                ? Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(img),
                                      fit: BoxFit.cover)),
                            )
                                : Icon(
                              Icons.person,
                              size: 52,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),) ,),



                      ],
                    )
                    ,
                    SizedBox(height: 30,),
                    textWidget(
                      text: 'تقيمات اصحاب النبات',
                      color: CommonColor.borderColor,
                      fontSize: 18,
                      fontFamily: AppDetails.cairoSemiBold,
                    ),
                    Stack(
                      children: [
                        FutureBuilder<List<ReviewsModel>>(
                            future: Firebase.shared.reviews(uid: uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ReviewsModel>? reviews = snapshot.data;
                                return CarouselSlider(
                                  carouselController: buttonCarouselController,
                                  options: CarouselOptions(
                                      height: 150,
                                      autoPlayInterval:
                                          const Duration(seconds: 15),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 600),
                                      enableInfiniteScroll: false,
                                      autoPlay: false,
                                      viewportFraction: 1),
                                  items: slider(reviews!),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      buttonCarouselController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear),
                                  child: Image.asset(
                                    Assets.shared.right,
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      buttonCarouselController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear),
                                  child: Image.asset(
                                    Assets.shared.left,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          page = userReviews.home;
                        });
                        },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        height: 44,
                        decoration: BoxDecoration(
                          color: "#DDE9BD".toHexa(),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(35)),
                        ),
                        child: Text(
                          'العوده',
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
                        2.0,
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
                      'المراجعات للاخصائي',
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

  List<Widget> slider(List<ReviewsModel> reviews) {
    List<Widget> items = [];
    var itemsCount = reviews.length - 1;
    for (var i = 0; i <= itemsCount; i++) {
      items.add(Builder(
        builder: (BuildContext context) {
          return Card(
            elevation: 4,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              side: BorderSide(color: Colors.white),
            ),
            child: SizedBox(
              width: 238,
              child: Column(
                children: [
                  FutureBuilder<UserModel>(
                      future: Firebase.shared.userByUid(uid: reviews[i].uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel? user = snapshot.data;;
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: user!.image != ""
                                ? Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(user.image),
                                      fit: BoxFit.cover)),
                            )
                                : Icon(
                              Icons.person,
                              size: 52,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(reviews[i].name),
                        RatingBarIndicator(
                          itemSize: 15,
                          rating: reviews[i].review,
                          itemCount: 5,
                          itemBuilder: (context, _) => Image.asset(
                            Assets.shared.rose,
                          ),
                        ),
                        Text(reviews[i].note),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ));
    }
    return items;
  }

  void openUrl({required String link}) {
    final Uri uri = Uri.parse(link);
    launchUrl(uri);
  }
}

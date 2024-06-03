import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../../Firebase.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';

class users extends StatefulWidget {
  const users({super.key});

  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {
  bool edit = false;
  String logo = '';
  String uid = '';
  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Stack(children: [
              Image.asset(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                Assets.shared.background,
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "اصحاب النباتات",
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
                        child: edit == false
                            ? FutureBuilder<List<UserModel>>(
                                future: Firebase.shared.users(
                                    status: Status.active, type: Usertype.user),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<UserModel>? items = snapshot.data;
                                    return Wrap(
                                        children: List.generate(
                                      items!.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              edit = true;
                                              logo = items[index].image;
                                              uid = items[index].uid;
                                            });
                                          },
                                          child: Card(
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
                                                  child: items[index].image !=
                                                          ""
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      items[index]
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
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        "${items[index].name} ${items[index].last}"),
                                                    Text(items[index].city),
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
                                })
                            : FutureBuilder<UserModel>(
                                future: Firebase.shared.userByUid(uid: uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    UserModel? user = snapshot.data;
                                    name.text = user!.name;
                                    last.text = user.last;
                                    email.text = user.email;
                                    phone.text = user.phone;
                                    address.text = user.address;
                                    city.text = user.city;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Center(
                                          child: Text(
                                            user.id,
                                            style: TextStyle(
                                                color: "#9f9f9f".toHexa(),
                                                fontSize: 14),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: name,
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
                                            controller: last,
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: phone,
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
                                              prefixIcon: Image.asset(
                                                Assets.shared.tel,
                                              ),
                                              hintText: "رقم الجوال ",
                                              fillColor: Colors.white,
                                              contentPadding: EdgeInsets.all(
                                                  8), // Added this
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: email,
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
                                              hintText:
                                                  "ادخل بريدك الالكتروني ",
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "    المدينة",
                                                    style: TextStyle(
                                                      color: "#8c8c8c".toHexa(),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: TextField(
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller: city,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        // Added this
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                        hintText:
                                                            "المدينة المنورة ",
                                                        fillColor: Colors.white,
                                                        prefixIcon: Image.asset(
                                                          Assets.shared
                                                              .vectorCity,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "    العنوان",
                                                    style: TextStyle(
                                                      color: "#8c8c8c".toHexa(),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: TextField(
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller: address,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: CommonColor
                                                                .calendarColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        filled: true,
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                        hintText: "البدراني",
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        prefixIcon: Image.asset(
                                                          Assets.shared
                                                              .vectorCity,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                        5.0,
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
                                                  Firebase.shared
                                                      .updateAccountUser(
                                                          context,
                                                          scaffoldKey:
                                                              scaffoldKey,
                                                          name: name.text,
                                                          last: last.text,
                                                          email: email.text,
                                                          address: address.text,
                                                          city: city.text,
                                                          phone: phone.text,
                                                          password:
                                                              user.password,
                                                          experience:
                                                              user.experience,
                                                          certificate:
                                                              user.certificate,
                                                          years: user.years,
                                                          cv: user.cv,
                                                          userId: user.uid,
                                                          userType:
                                                              user.userType,
                                                          status: user
                                                              .accountStatus,
                                                          section: user.section,
                                                          image: user.image, );
                                                },
                                                child: Text(
                                                  'حفظ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          "#c7d5aa".toHexa()),
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
                                                        5.0,
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
                                                      color:
                                                          "#c7d5aa".toHexa()),
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
                                                        5.0,
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        surfaceTintColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: Text(
                                                          " هل انت متاكد من حذف حسابك؟",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: "#688665"
                                                                .toHexa(),
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
                                                                      name: name
                                                                          .text,
                                                                      last: last
                                                                          .text,
                                                                      email: email
                                                                          .text,
                                                                      address: user
                                                                          .address,
                                                                      city: user
                                                                          .city,
                                                                      phone: phone
                                                                          .text,
                                                                      password: user
                                                                          .password,
                                                                      experience:
                                                                          user
                                                                              .experience,
                                                                      certificate:
                                                                          user
                                                                              .certificate,
                                                                      years: user
                                                                          .years,
                                                                      cv: user
                                                                          .cv,
                                                                      userId: user
                                                                          .uid,
                                                                      userType: user
                                                                          .userType,
                                                                      status: Status
                                                                          .pending,
                                                                      section: user
                                                                          .section,
                                                                      image: user
                                                                          .image, );
                                                                  Firebase
                                                                      .shared
                                                                      .signOut(
                                                                          context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 22,
                                                                  width: 64,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: const BorderRadius.all(Radius.circular(
                                                                              20)),
                                                                          color: Colors
                                                                              .white,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.red,
                                                                          )),
                                                                  child:
                                                                      const Text(
                                                                    'حذف',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
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
                                                                child:
                                                                    Container(
                                                                  height: 22,
                                                                  width: 64,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color:
                                                                              "#9DBA89".toHexa())),
                                                                  child: Text(
                                                                    'الغاء',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
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
                                })),
                  ],
                ),
              ),
              Visibility(
                visible: edit,
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
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
                                      image: NetworkImage(logo),
                                      fit: BoxFit.cover)),
                            )
                          : Icon(
                              Icons.person,
                              size: 52,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}

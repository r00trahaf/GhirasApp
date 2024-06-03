import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../../Firebase.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';

class mewa extends StatefulWidget {
  const mewa({super.key});

  @override
  State<mewa> createState() => _mewaState();
}

class _mewaState extends State<mewa> {

  bool edit = false;
  String uid = '';
  String logo = '';
  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
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
              ),edit == false ?
              Container(
                margin: const EdgeInsets.only(top: 90),
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
                          "ممثلي وزارة الزراعة",
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
                            future: Firebase.shared.users(
                                status: Status.active,
                                type: Usertype.mewa),
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
                ),
              ):
              Container(
                margin: const EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: FutureBuilder<UserModel>(
                    future: Firebase.shared.userByUid(uid: uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserModel? user = snapshot.data;
                        name.text = user!.name;
                        last.text = user.last;
                        email.text = user.email;
                        phone.text = user.phone;
                        city.text = user.city;
                        return  Container(
                          padding: const EdgeInsets.only(top: 80),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${user!.name} ${user.last}',
                                style: TextStyle(
                                    color: "#365133".toHexa(), fontSize: 20),
                              ),
                              Text(
                                user.city,
                                style: TextStyle(
                                    color: "#365133".toHexa(), fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 300,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "الاسم الاول ",
                                        style: TextStyle(
                                            color: "#365133".toHexa(),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 316,
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
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextField(
                                  controller: name,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    // Added this
                                    hintStyle:
                                    TextStyle(color: Colors.grey[800]),
                                    hintText: "زهراء",
                                    fillColor: Colors.grey[100],
                                    prefixIcon: Image.asset(
                                      Assets.shared.profilePage,
                                    ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "الاسم الاخير",
                                        style: TextStyle(
                                            color: "#365133".toHexa(),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 316,
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
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextField(
                                  controller: last,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    // Added this
                                    hintStyle:
                                    TextStyle(color: Colors.grey[800]),
                                    hintText: "زهراء",
                                    fillColor: Colors.grey[100],
                                    prefixIcon: Image.asset(
                                      Assets.shared.profilePage,
                                    ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "رقم الجوال ",
                                        style: TextStyle(
                                            color: "#365133".toHexa(),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 316,
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
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextField(
                                  controller: phone,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    // Added this
                                    hintStyle:
                                    TextStyle(color: Colors.grey[800]),
                                    hintText: "زهراء",
                                    fillColor: Colors.grey[100],
                                    prefixIcon: Image.asset(
                                      Assets.shared.tel,
                                    ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "الايميل",
                                        style: TextStyle(
                                            color: "#365133".toHexa(),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 316,
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
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextField(
                                  controller: email,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    // Added this
                                    hintStyle:
                                    TextStyle(color: Colors.grey[800]),
                                    hintText: "زهراء",
                                    fillColor: Colors.grey[100],
                                    prefixIcon: Image.asset(
                                      Assets.shared.email,
                                    ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "العنوان",
                                        style: TextStyle(
                                            color: "#365133".toHexa(),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 316,
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
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextField(
                                  controller: city,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: "#f3f3f3".toHexa(),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    // Added this
                                    hintStyle:
                                    TextStyle(color: Colors.grey[800]),
                                    hintText: "زهراء",
                                    fillColor: Colors.grey[100],
                                    prefixIcon: Image.asset(
                                      Assets.shared.vectorCity,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                            address: user.address,
                                            city: user.city,
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
                                        'تعديل',
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
                                        borderRadius: const BorderRadius.all(
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
                                                            email: email.text,
                                                            address:
                                                            user.address,
                                                            city: user.city,
                                                            phone: phone.text,
                                                            password:
                                                            user.password,
                                                            experience: user
                                                                .experience,
                                                            certificate: user
                                                                .certificate,
                                                            years: user.years,
                                                            cv: user.cv,
                                                            userId: user.uid,
                                                            userType:
                                                            user.userType,
                                                            status: Status
                                                                .pending,
                                                            section:
                                                            user.section,
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
                                                            border: Border
                                                                .all(
                                                              color: Colors
                                                                  .red,
                                                            )),
                                                        child: const Text(
                                                          'حذف',
                                                          textAlign: TextAlign
                                                              .center,
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
                                                                .all(
                                                                Radius.circular(
                                                                    20)),
                                                            color:
                                                            Colors.white,
                                                            border: Border.all(
                                                                color: "#9DBA89"
                                                                    .toHexa())),
                                                        child: Text(
                                                          'الغاء',
                                                          textAlign: TextAlign
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
                                            fontSize: 15, color: Colors.red),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 300,
                        );
                      }
                    })
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
                              image: NetworkImage(
                                  logo),
                              fit: BoxFit.cover)),
                    ) : Icon(
                      Icons.person,
                      size: 52,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary,
                    ),
                  ),
                ),
              ),),
            ]
           )
        ));
  }
}

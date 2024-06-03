import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/enum/Usertype.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../../Firebase.dart';
import '../../Model/UserModel.dart';
import '../../enum/status.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';
import '../HomePage.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  Status status = Status.active;
  Usertype userType = Usertype.user;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool account = false;
  bool admin = false;
  Usertype selection = Usertype.user;
  TextEditingController name = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController userId = TextEditingController();

  TextEditingController experience = TextEditingController();
  TextEditingController certificate = TextEditingController();
  TextEditingController years = TextEditingController();
  TextEditingController cv = TextEditingController();
  TextEditingController section = TextEditingController();
  TextEditingController image = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return admin == false
        ? FutureBuilder<UserModel>(
            future: Firebase.shared.userByUid(uid: Firebase.shared.auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? user = snapshot.data;
                return SingleChildScrollView(
                    child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        child: Stack(children: [
                          Image.asset(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            Assets.shared.backgroundAmin,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 80),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      children: [
//                                        Image.asset(
//                                           Assets.shared.vector,
//                                           height: 17,
//                                           width: 18,
//                                         ),
                                        Text(
                                          " اهلا ${user!.name}",
                                          style: TextStyle(
                                              color: "#365133".toHexa(),
                                              fontSize: 35),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                                userType: Usertype.admin,
                                                currentIndex: 0,
                                              )),
                                      ModalRoute.withName('/HomePage'),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'عرض بيانات الحساب',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                                userType: Usertype.admin,
                                                currentIndex: 4,
                                              )),
                                      ModalRoute.withName('/HomePage'),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'عرض قائمة أخصائي النبات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                                userType: Usertype.admin,
                                                currentIndex: 3,
                                              )),
                                      ModalRoute.withName('/HomePage'),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'عرض قائمة أصحاب النباتات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                                userType: Usertype.admin,
                                                currentIndex: 1,
                                              )),
                                      ModalRoute.withName('/HomePage'),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'عرض ممثلي وزارة الزراعة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      admin = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'إدارة الحسابات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/SupportPage", (route) => true);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 316,
                                    height: 56,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'إدارة طلب الدعم',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: "#000000".toHexa(),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])));
              } else {
                return const SizedBox(
                  height: 300,
                );
              }
            })
        : SingleChildScrollView(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Stack(
                    children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    Assets.shared.manager,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 80),
                    margin: const EdgeInsets.only(top: 140),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: account == false
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.shared.jrs,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          admin = false;
                                        });
                                      },
                                      child: const Text(
                                        "الرئيسية",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )),
                                  Image.asset(
                                    Assets.shared.homeIcon,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "الاشعارات",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )),
                                  Image.asset(
                                    Assets.shared.adda9fr,
                                  ), //3
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          account = true;
                                          name.text = '';
                                          last.text = '';
                                          email.text = '';
                                          address.text = '';
                                          city.text = '';
                                          phone.text = '';
                                          password.text = '';
                                          experience.text = '';
                                          certificate.text = '';
                                          years.text = '';
                                          cv.text = '';
                                          section.text = '';
                                          userId.text = '';
                                          selection = selection;
                                        });
                                      },
                                      child: const Text(
                                        "اضافة حساب",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )),
                                ],
                              ),
                              Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 350,
                                  ),
                                  child: FutureBuilder<List<UserModel>>(
                                      future: Firebase.shared.user(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<UserModel> items = [];
                                          for (var user in snapshot.data!) {
                                            if (user.uid != Firebase.shared.auth.currentUser!.uid && user.accountStatus == status && user.userType == userType) {items.add(user);
                                            }
                                          }
                                          return Wrap(
                                              children: List.generate(
                                                  items.isEmpty
                                                      ? items.length + 2
                                                      : items.length + 1,
                                                    (index) {
                                                      return index == 0
                                                          ? _header(items.length)
                                                          : (items.isEmpty
                                                          ? const Text(
                                                        "لا يوجد مستخدمين",
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                            Colors.black),
                                                      )
                                                          : _item(
                                                          user:
                                                          items[index - 1],
                                                          currentUser: Firebase
                                                              .shared
                                                              .auth
                                                              .currentUser!
                                                              .uid));
                                                    },
                                              ));
                                        } else {
                                          return const SizedBox(
                                            height: 300,
                                          );
                                        }
                                      }))
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 15,
                                    ),
                                    height: 47,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: "#5E875A"
                                              .toHexa(), //color of border
                                          width: 1, //width of border
                                        ),
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
                                        borderRadius: BorderRadius.circular(25)),
                                    child: SegmentedButton<Usertype>(
                                      showSelectedIcon: false,
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return "#5E875A".toHexa();
                                            }
                                            return Colors.white;
                                          },
                                        ),
                                      ),
                                      segments: const <ButtonSegment<Usertype>>[
                                        ButtonSegment<Usertype>(
                                            value: Usertype.user,
                                            label: Text('صاحب نبات')),
                                        ButtonSegment<Usertype>(
                                            value: Usertype.specialist,
                                            label: Text('اخصائي')),
                                        ButtonSegment<Usertype>(
                                            value: Usertype.mewa,
                                            label: Text('ممثل الزراعة')),
                                      ],
                                      selected: {selection},
                                      onSelectionChanged: (Set<Usertype> newSelection) {
                                        setState(() {
                                          selection = newSelection.first;
                                        });
                                      },
                                      multiSelectionEnabled: false,
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, right: 20),
                                      child: Text(
                                        "نوع الحساب",
                                        style: TextStyle(
                                          color: "#365133".toHexa(),
                                          fontSize: 20,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: name,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'الاسم الاول',
                                      labelText: 'الاسم الاول',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: name,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'الاسم الاول',
                                          labelText: 'الاسم الاول',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: last,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'الاسم الاخير',
                                          labelText: 'الاسم الاخير',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: name,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'الاسم الاول',
                                      labelText: 'الاسم الاول',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: last,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'الاسم الاخير',
                                      labelText: 'الاسم الاخير',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: email,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'البريد الالكتروني',
                                      labelText: 'البريد الالكتروني',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: last,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'الاسم الاخير',
                                      labelText: 'الاسم الاخير',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: password,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'كلمة السر المؤقته',
                                      labelText: 'كلمة السر المؤقته',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: phone,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'رقم الجوال',
                                      labelText: 'رقم الجوال',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: password,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'كلمة السر المؤقته',
                                      labelText: 'كلمة السر المؤقته',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: email,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'البريد الالكتروني',
                                      labelText: 'البريد الالكتروني',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: password,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'كلمة السر المؤقته',
                                      labelText: 'كلمة السر المؤقته',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: email,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'البريد الالكتروني',
                                      labelText: 'البريد الالكتروني',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: phone,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'رقم الجوال',
                                      labelText: 'رقم الجوال',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: city,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'المدينة',
                                          labelText: 'المدينة',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: address,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'العنوان',
                                          labelText: 'العنوان',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: phone,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'رقم الجوال',
                                      labelText: 'رقم الجوال',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.user,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: city,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'المدينة',
                                          labelText: 'المدينة',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: address,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'العنوان',
                                          labelText: 'العنوان',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: certificate,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'الشهادة',
                                          labelText: 'الشهادة',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 47,
                                      width: 170,
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
                                          BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: years,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                            decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: "#5E875A".toHexa(),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          hintText: 'سنوات الخبرة',
                                          labelText: 'سنوات الخبرة',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: section,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'القسم',
                                      labelText: 'القسم',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: selection == Usertype.specialist,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: cv,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'السيرة الذاتية',
                                      labelText: 'السيرة الذاتية',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
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
                              ),
                              Visibility(
                                visible: selection == Usertype.mewa,
                                child: Container(
                                  height: 47,
                                  width: 350,
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: address,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: "#5E875A".toHexa(),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                      ),
                                      hintText: 'العنوان',
                                      labelText: 'العنوان',
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
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
                                  InkWell(
                                    onTap: () {
                                      if(userId.text == ''){
                                        if (selection == Usertype.user){
                                          if (name.text == "" || last.text == "" || password.text == "" || email.text == "" || phone.text == "" || address.text == "" || city.text == "" ){
                                            scaffoldKey.showTosta(context,
                                                message: 'يرجى تعبئة جميع الحقول', isError: true);
                                            return;
                                          }
                                          Firebase.shared.createAccount(context,
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
                                              userType: selection,
                                              status: Status.active,
                                          );
                                        } else if(selection == Usertype.specialist){
                                          if (name.text == "" || last.text == "" || password.text == "" || email.text == "" || phone.text == "" || address.text == "" || city.text == "" ){
                                            scaffoldKey.showTosta(context,
                                                message: 'يرجى تعبئة جميع الحقول', isError: true);
                                            return;
                                          }
                                          Firebase.shared.createAccount(context,
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
                                            userType: selection,
                                            status: Status.active,
                                          );
                                        } else if (selection == Usertype.mewa){
                                          if (section.text == "" || name.text == "" || last.text == "" || password.text == "" || email.text == "" || phone.text == "" || address.text == ""){
                                            scaffoldKey.showTosta(context,
                                                message: 'يرجى تعبئة جميع الحقول', isError: true);
                                            return;
                                          }
                                          Firebase.shared.createAccount(context,
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
                                            userType: selection,
                                            status: Status.active,
                                          );
                                        }
                                      } else{
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
                                            image: image.text
                                        );
                                      }
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
                                            color: "#9DBA89".toHexa(),
                                          )),
                                      child: Text(
                                        'حفظ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: "#9DBA89".toHexa()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        account = false;
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
                                          border: Border.all(
                                              color: "#9DBA89".toHexa())),
                                      child: Text(
                                        'الغاء',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: "#9DBA89".toHexa()),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ), /*1*/
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 111,
                      margin: const EdgeInsets.only(top: 100),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ادارة الحسابات',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                          Visibility(
                              visible: account,
                              child: Text(
                                "اضافة حساب",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: "#9DBA89".toHexa(),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ]
                )
            )
    );
  }

  Widget _header(length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
            onPressed: () {
              setState(() {
                userType = Usertype.user;
              });
            },
            child: const Text(
              'اصحاب النباتات',
              style: TextStyle(fontSize: 15, color: Colors.black),
            )),
        TextButton(
            onPressed: () {
              setState(() {
                userType = Usertype.specialist;
              });
            },
            child: const Text('أخصائي النبات',
                style: TextStyle(fontSize: 15, color: Colors.black))),
        TextButton(
            onPressed: () {
              setState(() {
                userType = Usertype.mewa;
              });
            },
            child: const Text('ممثلي وزارة الزراعة',
                style: TextStyle(fontSize: 15, color: Colors.black))),

      ],
    );
  }

  Widget _item({required UserModel user, currentUser}) {
    return Card(
        elevation: 4,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: user.image != ""
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
                  color: Theme.of(context)
                      .colorScheme
                      .secondary,
                ),
              ),
              title: Text("${user.name} ${user.last}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.city),
                  Visibility(
                      visible: userType == Usertype.user,
                      child: Text(user.city))
                ],
              ),
            ),
            Visibility(
                visible: Status.active == status,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                title: textWidget(
                                  textAlign: TextAlign.center,
                                  text: "هل انت متاكد من حذف الحساب",
                                  fontSize: 20,
                                  fontFamily: AppDetails.cairoRegular,
                                  color: CommonColor.fillColor,
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          scaffoldKey.showTosta(context, message: 'تم حذف الحساب', isError: false);
                                          Firebase.shared.deleteAccountUser(
                                            context,
                                            scaffoldKey: scaffoldKey,
                                            name: user.name,
                                            last: user.last,
                                            email: user.email,
                                            address: user.address,
                                            city: user.city,
                                            phone: user.phone,
                                            password: user.password,
                                            experience: user.experience,
                                            certificate: user.certificate,
                                            years: user.years,
                                            cv: user.cv,
                                            userId: user.uid,
                                            userType: user.userType,
                                            status: Status.pending,
                                            section: user.section,
                                            image: user.image,);

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
                                              const BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.white,
                                              border: Border.all(
                                                color: CommonColor.fillColor,
                                              )),
                                          child: Text(
                                            'حفظ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: CommonColor.fillColor,
                                            ),
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
                                              const BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                  CommonColor.fillColor)),
                                          child: Text(
                                            'الغاء',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: CommonColor.fillColor,
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
                          Assets.shared.deleteUser,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            account = true;
                            name.text = user.name;
                            last.text = user.last;
                            email.text = user.email;
                            address.text = user.address;
                            city.text = user.city;
                            phone.text = user.phone;
                            password.text = user.password;
                            experience.text = user.experience;
                            certificate.text = user.certificate;
                            years.text = user.years;
                            cv.text = user.cv;
                            section.text = user.section;
                            userId.text = user.uid;
                            selection = user.userType;
                          });
                        },
                        child: Image.asset(
                          Assets.shared.userPen,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  upload(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      cv.text = (await Firebase.shared.upload(folderName: email.text, pdfName: file.name, file: XFile('${file.path}')))!;
      scaffoldKey.showTosta(context,
          message: 'تم تحديد ملف السيرة الذاتية', isError: false);
    } else {
      scaffoldKey.showTosta(context,
          message: 'يرجى تحديد ملف السيرة الذاتية', isError: true);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../Firebase.dart';
import '../../Model/ReportsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/Homemewa.dart';
import '../../enum/Usertype.dart';
import '../../enum/report.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';
import '../HomePage.dart';

class HomeMewa extends StatefulWidget {
  const HomeMewa({super.key});

  @override
  State<HomeMewa> createState() => _HomeMewaState();
}

class _HomeMewaState extends State<HomeMewa> {
  Home page = Home.home;

  String name = "";
  String uid = "";
  late ReportsModel reportmodel;

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == Home.home) {
      return home(context);
    } else if (page == Home.users) {
      return user(context);
    } else if (page == Home.reports) {
      return reports(context);
    } else if (page == Home.report) {
      return report(context);
    }
  }

  home(context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: FutureBuilder<UserModel>(
              future: Firebase.shared
                  .userByUid(uid: Firebase.shared.auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel? user = snapshot.data;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              Assets.shared.backgroundMewa,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 80),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: AssetImage(
                                    Assets.shared.backgroundProfile,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 80),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: user!.image != ""
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
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
//                                  Image.asset(
//                                     Assets.shared.vector,
//                                     height: 17,
//                                     width: 20,
//                                   ),
                                  const Text(
                                    'اهلا بك!',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ),
                                ],
                              ),
                              Text(
                                '${user!.name} ${user.last}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Text(
                                user.section,
                                style: TextStyle(
                                    color: "#9DBA89".toHexa(), fontSize: 12),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            HomePage(
                                              userType: Usertype.mewa,
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
                                      'تعديل الحساب',
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
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            HomePage(
                                              userType: Usertype.mewa,
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
                                      'اضافة اخصائي جديد',
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
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            HomePage(
                                              userType: Usertype.mewa,
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
                                      ' الطلبات',
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
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            HomePage(
                                              userType: Usertype.mewa,
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
                                      'عرض قائمة اخصائيين النباتات ',
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
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    page = Home.users;
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
                                      'تقارير الجلسات',
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
                        )
                      ]);
                } else {
                  return const SizedBox();
                }
              })),
    ));
  }

  user(context) {
    return SingleChildScrollView(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Stack(children: [
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(top: 100),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
//                          Image.asset(
//                             Assets.shared.vector,
//                             height: 17,
//                             width: 20,
//                           ),
                          const Text(
                            'تقارير الجلسات',
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                          ),
                          child: FutureBuilder<List<UserModel>>(
                              future: Firebase.shared.users(
                                  status: Status.active,
                                  type: Usertype.specialist),
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
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Colors.white,
                                                    child: user[index].image != ""
                                                        ? Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                          BoxShape.circle,
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
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                  ),
                                                  title: Text(user[index].name),
                                                  trailing: Image.asset(
                                                    Assets.shared.jrs,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    "#${user[index].id}",
                                                  ),
                                                  subtitle: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        page = Home.reports;
                                                        name = user[index].name;
                                                        uid = user[index].uid;
                                                      });
                                                    },
                                                    child: FutureBuilder<
                                                        List<ReportsModel>>(
                                                        future: Firebase.shared
                                                            .reports(
                                                            uid: user[index].uid),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            List<ReportsModel>
                                                            reportNumber =
                                                            snapshot.data!;
                                                            return Text(
                                                              "عدد التقارير :${reportNumber.length}",
                                                            );
                                                          } else {
                                                            return const SizedBox();
                                                          }
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ));
                                } else {
                                  return const SizedBox();
                                }
                              })),
                    ],
                  ),
                ),
                Image.asset(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  Assets.shared.backgroundRectangle,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 120, right: 340),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: "#9DBA89".toHexa(),
                      ),
                      onPressed: () {
                        setState(() {
                          page = Home.home;
                        });
                      },
                    ),
                  ),
                ),
              ])),
        ));
  }

  reports(context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.backgroundRectangle,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 140),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
//                      Image.asset(
//                         Assets.shared.vector,
//                         height: 15,
//                         width: 18,
//                       ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "تقارير الجلسات",
                          style: TextStyle(
                              color: "#787878".toHexa(), fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(right: 30,),
                child: Text(
                  'الخاصة بـ$name',
                  style: TextStyle(color: "#688665".toHexa(), fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<ReportsModel>>(
                    future: Firebase.shared.reports(uid: uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ReportsModel> report = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          itemCount: report.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  page = Home.report;
                                  reportmodel = report[index];
                                });
                              },
                              child: Card(
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
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'الجلسة',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width: 80,
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
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color:
                                                            "#72B28A".toHexa(),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        )),
                                                    child: Text(
                                                      '${report[index].report == Report.online ? 'اون لاين' : 'زيارة ميدانية'}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(report[index].id!)
                                            ],
                                          ),
                                          Text(
                                              'تاريخ الجلسة: ${DateFormat('d MMM yyyy').format(report[index].createdDate)}'),
                                          Text(
                                              'عنوان الجلسة:${report[index].title}'),
                                        ],
                                      ))),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    })),
            Center(
              child: Container(
                width: 120,
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    border: Border.all(
                      color: "#9DBA89".toHexa(),
                    )),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      page = Home.users;
                    });
                  },
                  child: Text(
                    'العودة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: "#9DBA89".toHexa(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ])),
    );
  }

  report(context) {
    return SingleChildScrollView(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Stack(children: [
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  margin: const EdgeInsets.only(top: 100),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
//                          Image.asset(
//                             Assets.shared.vector,
//                             height: 17,
//                             width: 20,
//                           ),
                          const Text(
                            'تقرير الجلسة',
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                      Text(
                        reportmodel.id!,
                        style: TextStyle(color: "#688665".toHexa(), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              height: 47,
                              width: 333,
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
                                    color: "#9DBA89".toHexa(),
                                  )),
                              child: Center(
                                child: Text(
                                  reportmodel.title!,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 0, right: 25),
                            child: Text('عنوان الجلسة'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              height: 47,
                              width: 333,
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
                                    color: "#9DBA89".toHexa(),
                                  )),
                              child: Center(
                                child: Text(
                                  reportmodel.nameUser!,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 0, right: 25),
                            color: Colors.white,
                            child: Text('اسم صاحب النبات'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            height: 47,
                            width: 333,
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
                                  color: "#9DBA89".toHexa(),
                                )),
                            child: Center(
                              child: Text(
                                DateFormat('d MMM yyyy')
                                    .format(reportmodel.createdDate),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 0, right: 25),
                            child: Text('تاريخ الجلسة'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              height: 47,
                              width: 333,
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
                                    color: "#9DBA89".toHexa(),
                                  )),
                              child: Center(
                                child: Text(
                                  DateFormat('hh:mm a')
                                      .format(reportmodel.createdDate),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 0, right: 25),
                            child: Text('زمن الجلسة'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              height: 96,
                              width: 333,
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
                                    color: "#9DBA89".toHexa(),
                                  )),
                              child: Center(
                                child: Text(
                                  reportmodel.note!,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 0, right: 25),
                            child: Text('الملاحظات'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  height: 47,
                                  width: 167,
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
                                  child: Center(
                                    child: Text(
                                      reportmodel.idSpecialist!,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 0, right: 25),
                                child: Text('معرف الاخصائي'),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  height: 47,
                                  width: 160,
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
                                  child: Center(
                                    child: Text(
                                      reportmodel.idUser!,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 0, right: 25),
                                child: Text('معرف صاحب النبات'),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.backgroundRectangle,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 120, right: 340),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: "#9DBA89".toHexa(),
                      ),
                      onPressed: () {
                        setState(() {
                          page = Home.home;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 180, right: 250),
                  width: 120,
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
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: "#CCE4BC".toHexa(),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        page = Home.reports;
                      });
                    },
                    child: Text(
                      ' ${reportmodel.report == Report.online ? 'اون لاين' : 'زيارة ميدانية'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 710),
                    width: 120,
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
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        border: Border.all(
                          color: "#9DBA89".toHexa(),
                        )),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          page = Home.reports;
                        });
                      },
                      child: Text(
                        'العودة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: "#9DBA89".toHexa(),
                        ),
                      ),
                    ),
                  ),
                )
              ])),
        ));
  }
}

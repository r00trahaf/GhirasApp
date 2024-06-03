import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../Firebase.dart';
import '../../Model/ReportsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/report.dart';
import '../../enum/status.dart';
import '../../widgets/assets.dart';

class managementOrder extends StatefulWidget {
  const managementOrder({super.key});

  @override
  State<managementOrder> createState() => _managementOrderState();
}

class _managementOrderState extends State<managementOrder> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController rejected = TextEditingController();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              Stack(
                children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    Assets.shared.SpeciaListHome,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        margin: const EdgeInsets.only(top: 110),
                        width: 340,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'إدارة الطلبات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: "#365133".toHexa(),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
              StreamBuilder<List<ReportsModel>>(
                  stream: Firebase.shared.reportsStream(uid: Firebase.shared.auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ReportsModel>? items = [];
                      for (var add in snapshot.data!) {
                        if (add.status == Status.pending) {
                          items.add(add);
                        }
                      }
                      return Wrap(
                          children: List.generate(
                        items.length,
                        (index) {
                          return Padding(
                              padding: const EdgeInsets.all(15),
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
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerEnd,
                                    children: [
                                      ListTile(
                                        leading: FutureBuilder<UserModel>(
                                            future: Firebase.shared.userByUid(uid: items[index].uidSpecialist!),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                UserModel? user = snapshot.data;
                                                return CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child: user!.image != ""
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      user.image),
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
                                                );
                                              } else {
                                                return CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child:Icon(
                                                    Icons.person,
                                                    size: 52,
                                                    color: Theme.of(context).colorScheme.secondary,
                                                  ),
                                                );
                                              }
                                            }),
                                        title: Text(items[index].nameUser!),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(" ${items[index].report == Report.online ? 'اون لاين' : 'زيارة ميدانية'}/${DateFormat('d MMM yyyy').format(items[index].createdDate)}/${DateFormat('hh:mm a').format(items[index].createdDate)}"),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                name = items[index].nameUser!;
                                              });
                                                  showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    backgroundColor: Colors.white,
                                                    title: Image.asset(
                                                      height: 80,
                                                      width: 80,
                                                      Assets.shared.approve,
                                                    ),
                                                    content:  Text(
                                                      " تم قبول طلب جلسة مع  ${name} ، سيتم اشعار صاحب النبات بقبولك للطلب ",
                                                      textAlign: TextAlign.center,
                                                      style:
                                                          const TextStyle(fontSize: 18),
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Firebase.shared.updateReports(
                                                                  context,
                                                                  scaffoldKey:
                                                                      scaffoldKey,
                                                                  date: items[index]
                                                                      .createdDate,
                                                                  phone: items[index]
                                                                      .phone!,
                                                                  place: items[index]
                                                                      .place!,
                                                                  title: items[index]
                                                                      .title!,
                                                                  uidUser: items[index]
                                                                      .uidUser!,
                                                                  nameUser:
                                                                      items[index]
                                                                          .nameUser!,
                                                                  idUser:
                                                                      items[index]
                                                                          .idUser!,
                                                                  uidSpecialist:
                                                                      items[index]
                                                                          .uidSpecialist!,
                                                                  idSpecialist:
                                                                      items[index]
                                                                          .idSpecialist!,
                                                                  note: items[index]
                                                                      .note!,
                                                                  id: items[index]
                                                                      .id!,
                                                                  rejected:
                                                                      items[index]
                                                                          .rejected!,
                                                                  status: Status.active,
                                                                  report: items[index].report);
                                                              Navigator.of(context).pop();

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
                                                                      color: Colors
                                                                          .grey)),
                                                              child: const Text(
                                                                'ارسال',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .grey),
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
                                                                      color: Colors
                                                                          .grey)),
                                                              child: const Text(
                                                                'الغاء',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .grey),
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
                                              width: 25,
                                              height: 25,
                                              Assets.shared.checked,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                name = items[index].nameUser!;
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    backgroundColor: Colors.white,
                                                    title: Image.asset(
                                                      width: 80,
                                                      height: 80,
                                                      Assets.shared.cancel,
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                           Text(
                                                            "تم رفض طلب جلسة مع  ${name}  ، سيتم اشعار صاحب النبات برفضك للطلب.الرجاء كتابة سبب الرفض",
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextFormField(
                                                            controller: rejected,
                                                            textAlign:
                                                                TextAlign.center,
                                                            cursorColor:
                                                                Colors.black,
                                                            keyboardType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          40),
                                                              // <-- SEE HERE
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .black,
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
                                                                  color: Colors
                                                                      .black,
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
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                              ),
                                                            ),
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
                                                            onTap: () {
                                                              if (rejected.text == ""){
                                                                scaffoldKey.showTosta(context,
                                                                    message: 'هناك خطأ ما يرجى تعبئة جميع الحقول', isError: true);                                                                return;
                                                              }
                                                              Firebase.shared.updateReports(
                                                                  context,
                                                                  scaffoldKey:
                                                                      scaffoldKey,
                                                                  date: items[index]
                                                                      .createdDate,
                                                                  phone: items[index]
                                                                      .phone!,
                                                                  place: items[index]
                                                                      .place!,
                                                                  title: items[index]
                                                                      .title!,
                                                                  uidUser:
                                                                      items[index]
                                                                          .uidUser!,
                                                                  nameUser:
                                                                      items[index]
                                                                          .nameUser!,
                                                                  idUser:
                                                                      items[index]
                                                                          .idUser!,
                                                                  uidSpecialist:
                                                                      items[index]
                                                                          .uidSpecialist!,
                                                                  idSpecialist:
                                                                      items[index]
                                                                          .idSpecialist!,
                                                                  note:
                                                                      items[index]
                                                                          .note!,
                                                                  id: items[index]
                                                                      .id!,
                                                                  rejected:
                                                                      rejected.text,
                                                                  status: Status.cancel,
                                                                  report: items[index].report);
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
                                                              child: const Text(
                                                                'ارسال',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors.grey),
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
                                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                  color: Colors.white,
                                                                  border: Border.all(color: Colors.grey)),
                                                              child: const Text(
                                                                'الغاء',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors.grey),
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
                                              Assets.shared.decline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )));
                        },
                      ));
                    } else {
                      return const SizedBox();
                    }
                  }),
          ])),
    ));
  }
}

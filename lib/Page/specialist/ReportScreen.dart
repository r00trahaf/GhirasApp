import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../Firebase.dart';
import '../../Model/ReportsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/report.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Report page = Report.home;
  String reportsBy = '';
  ReportsModel? reports;

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == Report.online) {
      return online(context);
    } else if (page == Report.outside) {
      return outside(context);
    } else if (page == Report.home) {
      return home(context);
    } else if (page == Report.report) {
      return report(context);
    }
  }

  Widget home(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: FutureBuilder<List<ReportsModel>>(
              future: Firebase.shared
                  .reports(uid: Firebase.shared.auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ReportsModel>? items = [];
                  for (var add in snapshot.data!) {
                    var contain = items
                        .where((element) => element.uidUser == add.uidUser);
                    if (contain.isEmpty) {
                      items.add(add);
                    }
                  }
                  return Column(
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
                                alignment: Alignment.center,
                                child: Container(
                                    height: 111,
                                    margin: const EdgeInsets.only(top: 100),
                                    width: 300,
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
                                    child: Center(
                                      child: Text(
                                        'التقارير',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: "#365133".toHexa(),
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
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
                                  child: FutureBuilder<UserModel>(
                                      future: Firebase.shared.userByUid(
                                          uid: items[index].uidUser!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          UserModel? user = snapshot.data;
                                          return ListTile(
                                              leading: CircleAvatar(
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
                                              ),
                                              title: Text(user.name),
                                              subtitle: Text(user.city),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    page = Report.report;
                                                    reportsBy =
                                                        items[index].uidUser!;
                                                  });
                                                },
                                                child: Image.asset(
                                                    Assets.shared.Rectangle),
                                              ));
                                        } else {
                                          return ListTile(
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.person,
                                                  size: 52,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                              title:
                                                  Text(items[index].nameUser!),
                                              subtitle:
                                                  Text(items[index].place!),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    page = Report.report;
                                                    reportsBy =
                                                        items[index].uidUser!;
                                                  });
                                                },
                                                child: Image.asset(
                                                    Assets.shared.Rectangle),
                                              ));
                                        }
                                      })),
                            );
                          },
                        ),
                      ]);
                } else {
                  return const SizedBox();
                }
              })),
    ));
  }

  report(context) {
    return  Center(
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
                      Assets.shared.SpeciaListHome,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 180),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
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
                Expanded(child: FutureBuilder<List<ReportsModel>>(
                    future: Firebase.shared.reportsBy(uid: reportsBy),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ReportsModel>? items = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (items[index].report == Report.online) {
                                  setState(() {
                                    page = Report.online;
                                    reports = items[index];
                                  });
                                } else {
                                  setState(() {
                                    page = Report.outside;
                                    reports = items[index];
                                  });
                                }
                              },
                              child: Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 4,
                                  surfaceTintColor: "#f6f6f6".toHexa(),
                                  color: "#f6f6f6".toHexa(),
                                  shape:  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                      color: "#f6f6f6".toHexa(),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("الجلسة ",style: TextStyle(color: "#787878".toHexa()),),
                                            Text(items[index].id!,style: TextStyle(color: "#9DBA89".toHexa()),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("تاريخ الجلسة:  ",style: TextStyle(color: "#787878".toHexa()),),
                                            Text(DateFormat('d MMM yyyy')
                                                .format(items[index].createdDate),style: TextStyle(color: "#9DBA89".toHexa()),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("عنوان الجلسة: ",style: TextStyle(color: "#787878".toHexa()),),
                                            Text(items[index].title!,style: TextStyle(color: "#9DBA89".toHexa()),)
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    })),
                InkWell(
                  onTap: () {
                    setState(() {
                      page = Report.home;
                    });
                  },
                  child: Container(
                    width: 161,
                    height: 36,
                    decoration: BoxDecoration(
                      boxShadow:  [
                        BoxShadow(
                          color: "#c5c5c5".toHexa(),
                          offset: Offset(
                            0.0,
                            5.0,
                          ),
                          blurRadius: 0.10,
                          spreadRadius: 0.10,
                        ),
                      ],
                      color: "#D1DFC8".toHexa(),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        'العودة الى التقارير',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: "#ffffff".toHexa(),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ])),
    );
  }

  online(context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.visit,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                margin: const EdgeInsets.only(top: 140),
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                      blurRadius: 0.20,
                      spreadRadius: 0.20,
                    ),
                  ],
                  color: CommonColor.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 95,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: CommonColor.containerColor,
                          ),
                          color: CommonColor.containerColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(-0,
                                  -40), // Adjusted negative Y offset for shadow from top
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: textWidget(
                            text: "اون لاين",
                            color: CommonColor.secondTextWidgetColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "عنوان الجلسة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.title,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "رقم الجلسة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.id,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "اسم صاحب النبات",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.nameUser,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                        suffixIcon: Image.asset(Assets.shared.requests),
                        isReadyOnly: true,
                        label: "تاريخ الجلسة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: DateFormat('d MMM yyyy')
                            .format(reports!.createdDate),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "زمن الجلسة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText:
                            DateFormat('hh:mm a').format(reports!.createdDate),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                        isReadyOnly: true,
                        hintText: reports!.note,
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        label: 'الملاحظات',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextFormField(
                              isReadyOnly: true,
                              label: "معرف صاحب النبات",
                              textInputAction: TextInputAction.next,
                              validator: (msg) {
                                return null;
                              },
                              controller: TextEditingController(),
                              hintText: reports!.idUser,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CommonTextFormField(
                              isReadyOnly: true,
                              label: "معرف الاخصائي",
                              textInputAction: TextInputAction.next,
                              validator: (msg) {
                                return null;
                              },
                              controller: TextEditingController(),
                              hintText: reports!.idSpecialist,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70, left: 100, right: 100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: textWidget(
                            text: "الجلسة ",
                            fontSize: 22,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.checkedDarkColor,
                          ),
                        ),
                        subtitle: Center(
                          child: textWidget(
                            text: reports!.id,
                            fontSize: 19,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.calendarColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 100, right: 350),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          page = Report.home;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.right_chevron,
                        color: CommonColor.calendarColor,
                      ))),
            ],
          )),
    ));
  }

  outside(context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.visit,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                margin: const EdgeInsets.only(top: 140),
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                      blurRadius: 0.20,
                      spreadRadius: 0.20,
                    ),
                  ],
                  color: CommonColor.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 95,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: CommonColor.containerColor,
                          ),
                          color: CommonColor.containerColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(-0,
                                  -40), // Adjusted negative Y offset for shadow from top
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: textWidget(
                            text: "زيارة ميدانية",
                            color: CommonColor.secondTextWidgetColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "اسم صاحب النبات",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.nameUser,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 25),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "رقم الاتصال",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.phone,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 25),
                      CommonTextFormField(
                        isReadyOnly: true,
                        label: "المنطقة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.place,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 25),
                      CommonTextFormField(
                        suffixIcon: Image.asset(Assets.shared.map),
                        isReadyOnly: true,
                        label: "احداثيات المزرعة",
                        textInputAction: TextInputAction.next,
                        validator: (msg) {
                          return null;
                        },
                        controller: TextEditingController(),
                        hintText: reports!.place,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextFormField(
                              isReadyOnly: true,
                              label: "تاريخ الزيارة",
                              textInputAction: TextInputAction.next,
                              validator: (msg) {
                                return null;
                              },
                              controller: TextEditingController(),
                              hintText: DateFormat('d MMM yyyy')
                                  .format(reports!.createdDate),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CommonTextFormField(
                              isReadyOnly: true,
                              label: "زمن الزيارة",
                              textInputAction: TextInputAction.next,
                              validator: (msg) {
                                return null;
                              },
                              controller: TextEditingController(),
                              hintText: DateFormat('hh:mm a')
                                  .format(reports!.createdDate),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Table(
                          border: TableBorder.all(
                            color: CommonColor.calendarColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text('الرقم',
                                          style: TextStyle(
                                              fontFamily:
                                                  AppDetails.cairoRegular,
                                              fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text('المحصول',
                                        style: TextStyle(fontSize: 10)),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('الاشجار',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('حشرية',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('فطرية',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text("التسميد",
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                    "الرعاية",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text('1',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('طماطم',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('10',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(':مبيد حشري متخصص',
                                        style: TextStyle(fontSize: 10)),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('التسميد',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                          'سماد كالسيوم بورون.سماد عالي فس',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('ضبط الري',
                                          style: TextStyle(fontSize: 10))),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text('2',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('طماطم',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('10',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(':مبيد حشري متخصص',
                                        style: TextStyle(fontSize: 10)),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('التسميد',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                          'سماد كالسيوم بورون.سماد عالي فس',
                                          style: TextStyle(fontSize: 10))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('ضبط الري',
                                          style: TextStyle(fontSize: 10))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70, left: 100, right: 100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: textWidget(
                            text: "الجلسة ",
                            fontSize: 22,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.checkedDarkColor,
                          ),
                        ),
                        subtitle: Center(
                          child: textWidget(
                            text: reports!.id,
                            fontSize: 19,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.calendarColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 100, right: 350),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          page = Report.home;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.right_chevron,
                        color: CommonColor.calendarColor,
                      ))),
            ],
          )),
    ));
  }
}

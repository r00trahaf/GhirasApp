import 'dart:async';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/Firebase.dart';
import 'package:ghiras/Model/ReportsModel.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../Model/CallModel.dart';
import '../../Model/CaringModel.dart';
import '../../Model/EducationModel.dart';
import '../../Model/HeatModel.dart';
import '../../Model/PlantModel.dart';
import '../../Model/QuestionsModel.dart';
import '../../Model/TimesModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/HomeUser.dart';
import '../../enum/report.dart';
import '../../enum/status.dart';
import '../../user_profile.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/comment_evaluation.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';
import '../../widgets/sessionAlertDialogWidget.dart';
import '../sessionCall.dart';
import "package:http/http.dart" as http;
import 'dart:convert' as convert;
import '../../Api.dart';
import '../../Model/humidityModel.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

//
  List<EducationTap> educationWHIB = [];
  List<EducationModel> education = [
    EducationModel(
        id: '0',
        Title: 'تصميم المناظر الطبيعية',
        logo: Assets.shared.Rectangle1),
    EducationModel(
        id: '1', Title: 'امراض النباتات', logo: Assets.shared.diseases),
    EducationModel(
        id: '2', Title: 'كميات الري المناسبة', logo: Assets.shared.Rectangle3),
    EducationModel(
        id: '3', Title: 'ضبط الحساسات', logo: Assets.shared.Rectangle4),
    EducationModel(
        id: '4', Title: 'ادوات البستنه', logo: Assets.shared.Rectangle6),
    EducationModel(
        id: '5', Title: 'انواع النباتات', logo: Assets.shared.Rectangle5),
  ];
  List<EducationTap> educationTap = [

    EducationTap(
        id: '0',
        uid: '0',
        Title: 'تصميم المخططات للمناظر الطبيعة',
        logo: Assets.shared.Rectangle02),
    EducationTap(
        id: '1',
        uid: '1',
        Title:'امراض النبات الشائعة و علاجها',
        logo: Assets.shared.diseases),
    EducationTap(
        id: '2',
        uid: '2',
        Title: 'كميات الري المناسبة',
        logo: Assets.shared.Rectangle3),
    EducationTap(
        id: '3',
        uid: '3',
        Title: 'ضبط الحساسات',
        logo: Assets.shared.Rectangle04),
    EducationTap(
        id: '4',
        uid: '4',
        Title: 'ادوات البستنة',
        logo: Assets.shared.Rectangle6),
    EducationTap(
        id: '5',
        uid: '5',
        Title: 'انواع النباتات',
        logo: Assets.shared.Rectangle5),
  ];
  List<EducationDrs> educationHo = [
    EducationDrs(
        id: '0',
        uid: '0',
        Title:
            'تتضمن هندسة المناظر الطبيعية تخطيط وتصميم وإدارة ورعاية البيئات المبنية والطبيعية. بفضل مجموعة مهاراتهم الفريدة، يعمل مهندسو المناظر الطبيعية على تحسين صحة الإنسان والبيئة في جميع المجتمعات. إنهم يخططون ويصممون الحدائق والحرم الجامعية ومناظر الشوارع والممرات والساحات والمساكن وغيرها من المشاريع التي تعزز المجتمعات.',
        logo: [Assets.shared.eng, Assets.shared.john]),
    EducationDrs(
        id: '1',
        uid: '1',
        Title:
        'أمراض النباتات هي مشكلات صحية تصيب النباتات، وقد تنجم عن عدة عوامل مثل الفطريات أو البكتيريا أو الفيروسات أو الديدان الخيطية، أو الظروف البيئية السيئة.تختلف طرق العلاج والوقاية بناءً على نوع المرض والمسبب الرئيسي له. فيما يلي بعض الأمثلة على الأمراض الشائعة وطرق علاجها: البياض الدقيقي: هو مرض فطري يظهر على أوراق النباتات كمسحوق أبيض، مما يؤدي إلى تدهور صحة النبات وتقليل إنتاجيته. لعلاج هذا المرض، يمكن استخدام مبيدات الفطريات المخصصة للبياض الدقيقي، مع توفير تهوية جيدة حول النبات وتجنب الرطوبة الزائدة. تعفن الجذور: سببه الفطريات أو البكتيريا التي تؤدي إلى تعفن الجذور وفقدان النبات لثباته. لعلاج تعفن الجذور، يجب تحسين تصريف التربة، واستخدام مبيدات الفطريات إذا تم اكتشاف الإصابة مبكرًا، مع تجنب الري الزائد. ',
        logo: [Assets.shared.eng, Assets.shared.john]),
    EducationDrs(
        id: '2',
        uid: '2',
        Title:
        ' إرشادات عامة لكميات الري: الري العميق والقليل التكرار: من الأفضل عمومًا إعطاء النباتات ريًّا عميقًا ولكن بتكرار أقل. هذا يشجع الجذور على النمو بعمق بحثًا عن الماء، مما يعزز من قوة النبات- الري المبكر في الصباح أو في المساء: يساعد على تقليل فقدان الماء بسبب التبخر، كما يقلل من خطر الإصابة بالأمراض الناتجة عن الرطوبة الزائدة.-تجنب الري الزائد: الري الزائد يمكن أن يؤدي إلى تعفن الجذور ومشكلات أخرى. يجب السماح للتربة بأن تجف بين مرات الري.',
        logo: [Assets.shared.eng, Assets.shared.john]),
    EducationDrs(
        id: '3',
        uid: '3',
        Title:
        '  ضبط حساسات التربة مثل حساسات الرطوبة والري والحموضة وحساسات النيتروجين والفوسفور والبوتاسيوم هو جزء مهم من إدارة الحدائق والحقول لضمان نمو سليم للنباتات وتحسين إنتاجية المحاصيل. يمكن أن توفر هذه الحساسات معلومات قيمة تساعدك على اتخاذ قرارات مدروسة بشأن الري والتسميد والتحكم في الحموضة. ضبط حساس رطوبة التربة:لتركيب: غرس حساس الرطوبة في التربة على العمق الذي تفضله (غالبًا من 5 إلى 10 سم). تأكد من تجنب وضع الحساس بالقرب من جذور النباتات أو في مناطق تجمع المياه. -ضبط حساس الحموضة (pH):التركيب: اغمس الحساس في التربة أو استخدم محلولًا مائيًا لقياس الحموضة. -ضبط حساسات النيتروجين والفوسفور والبوتاسيوم (NPK):لتركيب: تختلف حساسات NPK حسب النوع؛ بعضها يتطلب عينات من التربة ليتم تحليلها في المختبر، بينما يمكن للبعض الآخر قياسها مباشرةً.',
        logo: [Assets.shared.eng, Assets.shared.john]),
  ];


//
  bool exchangePlant = false;
  bool questions = false;

//
  String id = "";
  String join = "";
  String join_Hibe = "";
  String logo = "";
  bool sensor = true;
  String plantId = '';
  ReportsModel? reports;
  bool availablebool = true;

//
  bool Edit = false;
  List<DropdownMenuItem<String>> downMenuItem = [];
  List<DropdownMenuItem<String>> downMenuItem1 = [];
  String? dropDownItem;
  String? dropDownItem1;
  bool isPlantToxicated = false;
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController searchTextField = TextEditingController();
  TextEditingController Field = TextEditingController();
  File? _imagePerson;
  String imagePerson = '';

//
  TextEditingController plants = TextEditingController();
  TextEditingController durationPlants = TextEditingController();
  TextEditingController notePlants = TextEditingController();
  TextEditingController number = TextEditingController();

//
  TextEditingController questionsSend = TextEditingController();

//
  TextEditingController replyQuestions = TextEditingController();

//

  DateTime availableDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      availableDate = DateTime(availableDate.year, availableDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      availableDate = DateTime(availableDate.year, availableDate.month + 1, 1);
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      availableDate = selectedDate;
    });
  }

  String _selectedAmPm = 'AM';
  final List<String> _ampm = ['AM', 'PM'];
  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<int> _minutes = List.generate(60, (index) => index);
  int _selectedHour = 1;
  int _selectedMinute = 0;
  UserHome page = UserHome.home;
  String email = '';
  String uid = '';
  String nameCall = '';

  List<DateTime> _getDatesInMonth(DateTime month) {
    var firstDayOfMonth = DateTime(month.year, month.month, 1);
    var lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    var days = List<DateTime>.generate(lastDayOfMonth.day,
        (index) => firstDayOfMonth.add(Duration(days: index)));
    return days;
  }

//
  String visible = '';

  bool isSelected(String selected) => visible == selected;

  toggleSelected(String selected) {
    if (!isSelected(selected)) {
      setState(() {
        visible = selected;
      });
    }
  }

//

  String field1 = '0';
  String field2 = '0';
  String field3 = '0';
  String field4 = '0';
  String field5 = '0';
  bool SnackBarshow = true;
  Timer? timer;

  _init() {
    timer =
        Timer.periodic(Duration(seconds: 2), (timer) => humidityApi(context));
  }

  HumidityModel? humidityModel;

  Color Field1 = "#FF1B1B".toHexa().withOpacity(0.3);
  Color Field2 = "#FF1B1B".toHexa().withOpacity(0.3);
  Color Field3 = "#FF1B1B".toHexa().withOpacity(0.3);
  Color Field4 = "#5EEF4E".toHexa().withOpacity(0.3);
  Color Field5 = "#FF1B1B".toHexa().withOpacity(0.3);

  Future humidityApi(BuildContext context) async {
    http.Response response = await Api.humidityUpdateUrl();
    var data = convert.jsonDecode(response.body);
    if ((response.statusCode == 200 || response.statusCode == 201)) {
      setState(() {
        humidityModel = HumidityModel.fromJson(data);
      });
      if (humidityModel!.feeds![0].field1 != null) {
        setState(() {
          field1 = humidityModel!.feeds![0].field1;
        });
        if (int.parse(field5) >= 350) {
          setState(() {
            Field1 = "#5EEF4E".toHexa().withOpacity(0.3);
          });
        } else {
          setState(() {
            Field1 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        }
      }
      if (humidityModel!.feeds![0].field2 != null) {
        setState(() {
          field2 = humidityModel!.feeds![0].field2;
        });
        if (int.parse(field5) >= 350) {
          setState(() {
            Field2 = "#5EEF4E".toHexa().withOpacity(0.3);
          });
        } else {
          setState(() {
            Field2 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        }
      }
      if (humidityModel!.feeds![0].field3 != null) {
        setState(() {
          field3 = humidityModel!.feeds![0].field3;
        });
        if (int.parse(field5) >= 350) {
          setState(() {
            Field3 = "#5EEF4E".toHexa().withOpacity(0.3);
          });
        } else {
          setState(() {
            Field3 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        }
      }
      if (humidityModel!.feeds![0].field4 != null) {
        setState(() {
          field4 = humidityModel!.feeds![0].field4!;
        });
        if (int.parse(field5) >= 80) {
          setState(() {
            Field4 = "#5EEF4E".toHexa().withOpacity(0.3);
          });
        } else {
          setState(() {
            Field4 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        }
      }
      if (humidityModel!.feeds![0].field5 != null) {
        setState(() {
          field5 = humidityModel!.feeds![0].field5;
        });
        if (int.parse(field5) >= 350 && SnackBarshow == true) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              iconRotationAngle: 0,
              textAlign: TextAlign.right,
              iconPositionLeft: 10,
              iconPositionTop: 10,
              icon: Icon(
                Icons.water_drop_rounded,
                color: CommonColor.containerColor,
              ),
              backgroundColor: CommonColor.whiteColor,
              textStyle: TextStyle(
                  color: CommonColor.checkedDarkColor,
                  fontSize: 16,
                  fontFamily: AppDetails.cairoRegular),
              message: "بدات عملية الري بسبب انخفاض رطوبة التربة",
            ),
          );
          setState(() {
            SnackBarshow = false;
          });
          setState(() {
            Field5 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        } else if (int.parse(field5) <= 350 && SnackBarshow == true) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              iconRotationAngle: 0,
              textAlign: TextAlign.right,
              iconPositionLeft: 10,
              iconPositionTop: 10,
              icon: Icon(
                Icons.water_drop_rounded,
                color: CommonColor.containerColor,
              ),
              backgroundColor: CommonColor.whiteColor,
              textStyle: TextStyle(
                  color: CommonColor.checkedDarkColor,
                  fontSize: 16,
                  fontFamily: AppDetails.cairoRegular),
              message: "توقفت عملية الري بسبب ارتفاع رطوبة التربة",
            ),
          );
          setState(() {
            SnackBarshow = false;
          });
          setState(() {
            Field5 = "#FF1B1B".toHexa().withOpacity(0.3);
          });
        }
      }
      return 1;
    } else if (response.statusCode == 401) {
      return 0;
    } else if (response.statusCode == 404) {
      return 0;
    } else if (response.statusCode == 400) {
      return 0;
    } else if (response.statusCode == 500) {
      return 0;
    } else {
      return 0;
    }
  }

//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlant();
    getData();
    _init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getPlant();
    getData();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == UserHome.home) {
      return start(context);
    } else if (page == UserHome.plant) {
      return plant(context);
    } else if (page == UserHome.sessionEnded) {
      return sessionEnded(context);
    } else if (page == UserHome.report) {
      return reportScreen(context);
    } else if (page == UserHome.add) {
      return addPlantsScreen(context);
    } else if (page == UserHome.sensor) {
      return dataSensorScreen(context);
    } else if (page == UserHome.showMeterScreen) {
      return showMeterScreen(context);
    } else if (page == UserHome.times) {
      return times(context);
    } else if (page == UserHome.rejectedRequest) {
      return rejectedRequest(context);
    } else if (page == UserHome.appointments) {
      return appointments(context);
    } else if (page == UserHome.Community) {
      return Community(context);
    } else if (page == UserHome.exchange) {
      return exchange(context);
    } else if (page == UserHome.Share) {
      return Share(context);
    } else if (page == UserHome.Educationback) {
      return Education(context);
    } else if (page == UserHome.educationInkWell) {
      return EducationInkWell(context);
    } else if (page == UserHome.educationInkDrs) {
      return educationInkDrs(context);
    } else if (page == UserHome.reports) {
      return report(context);
    } else if (page == UserHome.outside) {
      return outside(context);
    } else if (page == UserHome.online) {
      return online(context);
    }
  }

  Widget start(BuildContext context) {
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
                  return StreamBuilder<List<SessionCallModel>>(
                      stream: Firebase.shared.Call(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<SessionCallModel>? Session = snapshot.data;
                          if (Session!.isNotEmpty) {
                            Future.delayed(const Duration(seconds: 1), () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        surfaceTintColor: Colors.white,
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          "يوجد لديك جلسه الان مع ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: "#688665".toHexa(),
                                          ),
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder<UserModel>(
                                                future: Firebase.shared
                                                    .userByUid(
                                                        uid: Session.first
                                                            .uidSpecialist),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    UserModel? Specialist =
                                                        snapshot.data;
                                                    nameCall =
                                                        "${Specialist!.name} ${Specialist.last}";
                                                    return Text(
                                                      "${Specialist.name} ${Specialist.last}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            "#688665".toHexa(),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                }),
                                            Image.asset(Assets.shared.webinar),
                                          ],
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    page =
                                                        UserHome.sessionEnded;
                                                    id = Session.first.id;
                                                    logo = user!.image;
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Call(
                                                              id: Session
                                                                  .first.id,
                                                              name: nameCall,
                                                            )),
                                                  );
                                                },
                                                child: Container(
                                                  width: 123,
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
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: "#D1DFC8".toHexa(),
                                                      border: Border.all(
                                                        color:
                                                            "#D1DFC8".toHexa(),
                                                      )),
                                                  child: const Text(
                                                    'الدخول',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
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
                                                  width: 123,
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
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: "#D1DFC8".toHexa(),
                                                      border: Border.all(
                                                        color:
                                                            "#D1DFC8".toHexa(),
                                                      )),
                                                  child: const Text(
                                                    'الغاء',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ));
                                },
                              );
                            });
                          }
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      fit: BoxFit.cover,
                                      Assets.shared.backgroundUser,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          Assets.shared.login2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          Assets.shared.login2,
                                        ),
                                      ],
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
                                                          image: NetworkImage(
                                                              user.image),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/weather", (route) => true);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 168,
                                      height: 37,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'حالة الطقس',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: "#95ACB1".toHexa(),
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            Assets.shared.weather,
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      page = UserHome.plant;
                                    });
                                  },
                                  child: Container(
                                      width: 290,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: "#D1DFC8".toHexa(),
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
                                            Radius.circular(25)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "نباتاتي",
                                          style: TextStyle(
                                              color: "#365133".toHexa(),
                                              fontSize: 30),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          page = UserHome.showMeterScreen;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "بيانات\nالحساسات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          page = UserHome.times;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "جدولة\nمواعيد الري",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          page = UserHome.reports;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'التقارير',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          page = UserHome.appointments;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'المواعيد',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          page = UserHome.Educationback;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "المحتوى\nالتعليمي",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          page = UserHome.Community;
                                        });
                                      },
                                      child: Container(
                                          width: 138,
                                          height: 120,
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
                                            color: "#D1DFC8".toHexa(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "مجتمع\nالنبات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ]);
                        } else {
                          return const SizedBox();
                        }
                      });
                } else {
                  return const SizedBox();
                }
              })),
    ));
  }

  Widget sessionEnded(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<ReportsModel>(
            future: Firebase.shared.report(uid: id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ReportsModel? data = snapshot.data;
                return Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          Assets.shared.zigzagDesign,
                        ),
                        Positioned(
                            top: 140,
                            left: 200,
                            child: textWidget(
                              color: CommonColor.calendarColor,
                              text: "انتهت الجلسة",
                              fontFamily: AppDetails.cairoRegular,
                              fontSize: 25,
                            )),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 44, right: 44),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: Colors.black,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: CommonColor.calendarColor)),
                          child: Column(
                            children: [
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "رقم الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: data!.id,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "تاريخ الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: DateFormat('d MMM yyyy')
                                    .format(data.createdDate),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "زمن الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: DateFormat('hh:mm a')
                                    .format(data.createdDate),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "مكان الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: data.place,
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 70, left: 70),
                      child: Row(
                        children: [
                          Expanded(
                              child: CommonButton(
                            onPress: () {
                              setState(() {
                                page = UserHome.report;
                              });
                            },
                            text: "التقارير",
                            buttonColor: CommonColor.buttonColor,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CommonButton(
                            onPress: () {
                              comment_evaluation(
                                context,
                                action: (evaluation, ratingValue) async {
                                  if (evaluation == "") {
                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("الرجاء إدخال جميع الحقول"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    return;
                                  } else {
                                    Firebase.shared.createReviews(
                                      context,
                                      scaffoldKey: scaffoldKey,
                                      logo: logo,
                                      name: data.nameUser!,
                                      note: evaluation,
                                      uid: data.uidUser!,
                                      id: data.id!,
                                      uidSpecialist: data.uidSpecialist!,
                                      review: ratingValue,
                                    );
                                  }
                                },
                              );
                            },
                            text: "التقييم",
                            buttonColor: CommonColor.buttonColor,
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 70, left: 70),
                      child: CommonButton(
                        onPress: () {
                          setState(() {
                            page = UserHome.home;
                          });
                        },
                        text: "العودة",
                        buttonColor: CommonColor.buttonColor,
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }));
  }

  Widget reportScreen(BuildContext context) {
    return SingleChildScrollView(
        child: SingleChildScrollView(
            child: FutureBuilder<ReportsModel>(
                future: Firebase.shared.report(uid: id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ReportsModel? data = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                decoration: BoxDecoration(
                                  color: CommonColor.WidgetColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 55,
                                left: 20,
                                right: 20,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.57,
                                          child: Container(
                                            height: 44,
                                            width: 250,
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: data!.report ==
                                                                Report.outside
                                                            ? CommonColor
                                                                .containerColor
                                                            : Colors.white,
                                                        offset: const Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                        blurRadius: 0.10,
                                                        spreadRadius: 0.10,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 10),
                                                    child: textWidget(
                                                      text: "زيارة ميدانية",
                                                      color: CommonColor
                                                          .secondTextWidgetColor,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: data.report ==
                                                                Report.online
                                                            ? CommonColor
                                                                .containerColor
                                                            : Colors.white,
                                                        offset: const Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                        blurRadius: 0.10,
                                                        spreadRadius: 0.10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 10),
                                                    child: textWidget(
                                                      text: "اون لاين",
                                                      color: CommonColor
                                                          .secondTextWidgetColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "عنوان الجلسة",
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          hintText: data.title,
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "رقم الجلسة",
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          hintText: data.id,
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "اسم صاحب النبات",
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          hintText: data.nameUser,
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "تاريخ الجلسه",
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          hintText: DateFormat('d MMM yyyy')
                                              .format(data.createdDate),
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "زمن الجلسة",
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          hintText: DateFormat('hh:mm a')
                                              .format(data.createdDate),
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        CommonTextFormField(
                                          isReadyOnly: true,
                                          label: "الملاحظات",
                                          hintText: data.note,
                                          textInputAction: TextInputAction.next,
                                          validator: (msg) {
                                            return null;
                                          },
                                          controller: TextEditingController(),
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonTextFormField(
                                                isReadyOnly: true,
                                                label: "معرف صاحب النبات",
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (msg) {
                                                  return null;
                                                },
                                                controller:
                                                    TextEditingController(),
                                                hintText: data.idUser,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: CommonTextFormField(
                                                isReadyOnly: true,
                                                label: "معرف الاخصائي",
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (msg) {
                                                  return null;
                                                },
                                                controller:
                                                    TextEditingController(),
                                                hintText: data.idSpecialist,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 25,
                                left: 90,
                                right: 90,
                                child: Card(
                                  elevation: 4,
                                  shadowColor: Colors.grey,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: textWidget(
                                        text: "تقرير الجلسة",
                                        fontSize: 22,
                                        fontFamily: AppDetails.cairoRegular,
                                        color: CommonColor.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 50.0, right: 70, left: 70),
                                  child: CommonButton(
                                    onPress: () {
                                      setState(() {
                                        page = UserHome.sessionEnded;
                                      });
                                    },
                                    text: "العودة",
                                    borderRadius: 20,
                                    fontSize: 15,
                                    buttonColor: CommonColor.buttonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                })));
  }

  Widget plant(BuildContext context) {
    return StreamBuilder<List<PlantModel>>(
        stream: Firebase.shared.plants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PlantModel>? search = [];
            for (var searchDetail in snapshot.data!) {
              if (searchDetail.plant.contains(searchTextField.text) ||
                  searchDetail.plant.contains(searchTextField.text)) {
                search.add(searchDetail);
              }
            }
            return Column(
              children: [
                _header(search),
                Expanded(
                    child: GridView.custom(
                        gridDelegate: SliverWovenGridDelegate.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          pattern: [
                            const WovenGridTile(1.5),
                            const WovenGridTile(
                              10 / 12,
                              crossAxisRatio: 0.8,
                              alignment: AlignmentDirectional.bottomCenter,
                            ),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: search.length,
                          (context, index) => _item(search: search[index]),
                        )))
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _header(search) {
    return Center(
        child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.plantpage,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    left: 5,
                    top: 70,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            page = UserHome.home;
                          });
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: CommonColor.calendarColor,
                          size: 30,
                        ))),
                Container(
                    margin: const EdgeInsets.only(top: 130),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: "#D9D9D9".toHexa(),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 5,
                                spreadRadius: 0.10,
                              ),
                            ],
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(Assets.shared.filterIcon)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: "#D9D9D9".toHexa(),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 5,
                                spreadRadius: 0.10,
                              ),
                            ],
                          ),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  page = UserHome.add;
                                });
                              },
                              icon: Image.asset(Assets.shared.plusIcon)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: "#D9D9D9".toHexa(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  blurRadius: 5,
                                  spreadRadius: 0.10,
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(left: 20),
                            child: TextFormField(
                              onChanged: (value) {
                                search.clear();
                                if (searchTextField.text.isEmpty) {
                                  setState(() {});
                                  return;
                                }
                                setState(() {});
                              },
                              controller: searchTextField,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: "بحث",
                                  suffixIcon: searchTextField.text == ''
                                      ? Image.asset(Assets.shared.searchIcon)
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            searchTextField.clear();
                                            setState(() {});
                                          },
                                        ),
                                  filled: true,
                                  fillColor:
                                      CommonColor.whiteColor.withOpacity(0.5),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 200, left: 250, right: 40),
                  child: Stack(
                    children: [
                      textWidget(
                        text: "نباتاتي",
                        color: CommonColor.checkedDarkColor,
                        fontSize: 40,
                        fontFamily: AppDetails.cairoRegular,
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _item({required PlantModel search}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: InkWell(
          onTap: () {
            plantId = search.id;
            setState(() {
              page = UserHome.sensor;
            });
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(search.logo), fit: BoxFit.cover)),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shadowColor: CommonColor.blackColor,
                                  elevation: 10,
                                  surfaceTintColor: CommonColor.blackColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actionsPadding: const EdgeInsets.only(
                                      bottom: 20, top: 10),
                                  title: textWidget(
                                    text: " هل انت متاكد من حذف النبته؟",
                                    color: CommonColor.calendarColor,
                                    fontFamily: AppDetails.cairoRegular,
                                    fontSize: 18,
                                  ),
                                  actions: [
                                    CommonButton(
                                        elevationValue: 5,
                                        buttonColor: Colors.white,
                                        buttonWidth: 100,
                                        buttonHeight: 32,
                                        fontSize: 18,
                                        buttonFontFamily:
                                            AppDetails.cairoRegular,
                                        fontColor: CommonColor.redColor,
                                        borderSide: BorderSide(
                                            color: CommonColor.redColor),
                                        onPress: () {
                                          Firebase.shared.deletePlant(context,
                                              scaffoldKey: scaffoldKey,
                                              uid: search.id);
                                          Navigator.pop(context);
                                        },
                                        text: "حذف"),
                                    CommonButton(
                                        elevationValue: 5,
                                        buttonColor: Colors.white,
                                        buttonWidth: 100,
                                        buttonHeight: 32,
                                        fontSize: 18,
                                        buttonFontFamily:
                                            AppDetails.cairoRegular,
                                        fontColor: CommonColor.calendarColor,
                                        borderSide: BorderSide(
                                            color: CommonColor.calendarColor),
                                        onPress: () => Navigator.pop(context),
                                        text: "الغاء"),
                                  ],
                                );
                              },
                            );
                          },
                          child: Image.asset(
                            Assets.shared.cancel,
                            height: 25,
                            width: 25,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              Edit = true;
                              name.text = search.plant;
                              note.text = search.note;
                              imagePerson = search.logo;
                              isPlantToxicated = search.toxic;
                              dropDownItem = search.heat;
                              plantId = search.id;
                              page = UserHome.add;
                            });
                          },
                          child: Image.asset(
                            Assets.shared.editIcon,
                            height: 25,
                            width: 25,
                          )),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      search.plant,
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget addPlantsScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              // Background image
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.profileUser,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CommonColor.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      contentPadding: const EdgeInsets.only(right: 60),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              Edit = false;
                              name.text = '';
                              note.text = '';
                              imagePerson = '';
                              isPlantToxicated = false;
                              page = UserHome.plant;
                            });
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            color: CommonColor.calendarColor,
                            size: 30,
                          )),
                      title: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
//                            Image.asset(
//                               Assets.shared.vector,
//                               height: 21.88,
//                               width: 25,
//                             ),
                            textWidget(
                              text: Edit == false
                                  ? "اضافة نبته جديدة"
                                  : "تعديل البيانات",
                              color: CommonColor.blackColor,
                              fontSize: 30,
                              fontFamily: AppDetails.cairoRegular,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          UserModel? user = await UserProfile.shared.getUser();
                          email = user!.email;
                          uid = user.uid;
                          selectImgDialog(context);
                        },
                        child: _imagePerson != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: FileImage(_imagePerson!),
                                          fit: BoxFit.cover)),
                                ))
                            : imagePerson != ""
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: NetworkImage(imagePerson),
                                              fit: BoxFit.cover)),
                                    ))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        CommonColor.calendarLightColor,
                                    child: Image.asset(
                                      Assets.shared.cameraImage,
                                    ),
                                  )),
                    const SizedBox(height: 30),
                    CommonTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (msg) {
                        return null;
                      },
                      controller: name,
                      hintText: "الياسمين",
                      keyboardType: TextInputType.text,
                      label: "اسم النبته",
                    ),
                    const SizedBox(height: 30), // Adjust spacing as needed
                    CommonTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (msg) {
                        return null;
                      },
                      controller: note,
                      hintText: "مره كل اسبوع",
                      keyboardType: TextInputType.text,
                      label: "عدد ايام الري اسبوعيا",
                    ),
                    const SizedBox(height: 30), // Adjust spacing as needed
                    Align(
                        alignment: Alignment.centerRight,
                        child: textWidget(
                          text: "هل نبتتك سامه للحيوانات؟",
                          color: CommonColor.borderColor,
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 18,
                        )),
                    const SizedBox(height: 20), // Adjus
                    Container(
                        width: 211,
                        height: 43,
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
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPlantToxicated = true;
                                });
                              },
                              child: Container(
                                width: 104,
                                height: 43,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: isPlantToxicated
                                        ? CommonColor.calendarLightColor
                                        : CommonColor.whiteColor),
                                child: Center(
                                  child: textWidget(
                                    text: "نعم",
                                    color: CommonColor.blackColor,
                                    fontSize: 18,
                                    fontFamily: AppDetails.cairoRegular,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPlantToxicated = false;
                                });
                              },
                              child: Container(
                                  width: 104,
                                  height: 43,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: isPlantToxicated
                                          ? CommonColor.whiteColor
                                          : CommonColor.calendarLightColor),
                                  child: Center(
                                    child: textWidget(
                                      text: "لا",
                                      color: CommonColor.blackColor,
                                      fontSize: 18,
                                      fontFamily: AppDetails.cairoRegular,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      padding: EdgeInsets.zero,
                      items: downMenuItem,
                      onChanged: (String? newValue) {
                        setState(() => dropDownItem = newValue!);
                      },
                      value: dropDownItem,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 10, right: 22, bottom: 10, left: 12),
                        label: textWidget(
                          text: "مستويات الحرارة المناسبة لنبتتك",
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 18,
                          color: CommonColor.checkedDarkColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CommonColor.borderColor,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: CommonColor.blackColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: CommonColor.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: CommonColor.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: CommonColor.borderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.chevron_down,
                        color: CommonColor.calendarColor,
                        size: 20,
                      ),
                      hint: textWidget(
                        text: "15 - 30°C",
                        fontFamily: AppDetails.cairoRegular,
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                            elevationValue: 5,
                            buttonColor: Colors.white,
                            buttonWidth: 100,
                            buttonHeight: 32,
                            fontSize: 18,
                            buttonFontFamily: AppDetails.cairoRegular,
                            fontColor: CommonColor.calendarColor,
                            borderSide:
                                BorderSide(color: CommonColor.calendarColor),
                            onPress: () {
                              if (name.text == '' && note.text == '') {
                                scaffoldKey.showTosta(context,
                                    message: 'يرجى تعبئة جميع الحقول',
                                    isError: true);
                                return;
                              }

                              if (Edit == false) {
                                Firebase.shared.createPlant(context,
                                    scaffoldKey: scaffoldKey,
                                    plant: name.text,
                                    note: note.text,
                                    logo: imagePerson,
                                    uid: Firebase.shared.auth.currentUser!.uid,
                                    heat: dropDownItem!,
                                    toxic: isPlantToxicated);
                              } else {
                                Firebase.shared.updatePlant(context,
                                    scaffoldKey: scaffoldKey,
                                    plant: name.text,
                                    note: note.text,
                                    logo: imagePerson,
                                    uid: Firebase.shared.auth.currentUser!.uid,
                                    heat: dropDownItem!,
                                    toxic: isPlantToxicated,
                                    id: plantId);
                              }
                              setState(() {
                                page = UserHome.plant;
                              });
                            },
                            text: "حفظ"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }

  Widget dataSensorScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      fit: BoxFit.cover,
                      Assets.shared.charlota,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      margin: const EdgeInsets.only(top: 90),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CommonColor.whiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: FutureBuilder<PlantModel>(
                          future: Firebase.shared.plant(uid: plantId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              PlantModel? plant = snapshot.data;
                              return Column(
                                children: [
                                  ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    contentPadding:
                                        const EdgeInsets.only(right: 60),
                                    trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            page = UserHome.plant;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.chevron_right,
                                          color: CommonColor.calendarColor,
                                          size: 30,
                                        )),
                                    title: Align(
                                      alignment: Alignment.center,
                                      child: textWidget(
                                        text: plant!.plant,
                                        color: CommonColor.blackColor,
                                        fontSize: 35,
                                        fontFamily: AppDetails.cairoRegular,
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Image.network(
                                        plant.logo,
                                        height: 200,
                                        width: 350,
                                        fit: BoxFit.cover,
                                      )),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 95,
                                        width: 103,
                                        decoration: BoxDecoration(
                                          color: CommonColor.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                0.0,
                                                3.0,
                                              ),
                                              blurRadius: 3,
                                              spreadRadius: 0.10,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: CommonColor
                                                  .calendarLightColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(plant.note),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                                Assets.shared.raindropsIcon)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 95,
                                        width: 103,
                                        decoration: BoxDecoration(
                                          color: CommonColor.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                0.0,
                                                3.0,
                                              ),
                                              blurRadius: 3,
                                              spreadRadius: 0.10,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: CommonColor
                                                  .calendarLightColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(plant.toxic == true
                                                ? "سامة للحيوانات"
                                                : "غير سامة للحيوانات"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                                Assets.shared.animalPawIcon)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 95,
                                        width: 103,
                                        decoration: BoxDecoration(
                                          color: CommonColor.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                0.0,
                                                3.0,
                                              ),
                                              blurRadius: 3,
                                              spreadRadius: 0.10,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: CommonColor
                                                  .calendarLightColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder<HeatModel>(
                                                future: Firebase.shared
                                                    .heat(uid: plant.heat),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    HeatModel? temperatureIcon =
                                                        snapshot.data;
                                                    return Text(
                                                        temperatureIcon!.heat);
                                                  } else {
                                                    return const Text(
                                                        "15 - 30°C");
                                                  }
                                                }),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                                Assets.shared.temperatureIcon)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              dropDownItem1 = plant.id;
                                              page = UserHome.times;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CommonColor.whiteColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                    blurRadius: 5,
                                                    spreadRadius: 0.10,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                border: Border.all(
                                                    color: CommonColor
                                                        .calendarLightColor)),
                                            child: ListTile(
                                              leading: Image.asset(
                                                  Assets.shared.timetableIcon),
                                              trailing: textWidget(
                                                text: "جدولة مواعيد الري",
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: sensor == false
                                              ? () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        titlePadding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        shadowColor: CommonColor
                                                            .blackColor,
                                                        elevation: 10,
                                                        surfaceTintColor:
                                                            CommonColor
                                                                .blackColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        actionsPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 20,
                                                                top: 20),
                                                        title: Center(
                                                          child: RichText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "هل تود اعداد حساس جديد ؟",
                                                                      style:
                                                                          TextStyle(
                                                                        color: CommonColor
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            AppDetails.cairoRegular,
                                                                        fontSize:
                                                                            22,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            "لنبتتك؟",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              CommonColor.blackColor,
                                                                          fontFamily:
                                                                              AppDetails.cairoRegular,
                                                                          fontSize:
                                                                              22,
                                                                        ))
                                                                  ])),
                                                        ),
                                                        actions: [
                                                          CommonButton(
                                                              elevationValue: 5,
                                                              buttonColor:
                                                                  Colors.white,
                                                              buttonWidth: 100,
                                                              buttonHeight: 32,
                                                              fontSize: 18,
                                                              buttonFontFamily:
                                                                  AppDetails
                                                                      .cairoRegular,
                                                              fontColor: CommonColor
                                                                  .calendarColor,
                                                              borderSide: BorderSide(
                                                                  color: CommonColor
                                                                      .calendarColor),
                                                              onPress: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      actionsPadding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              20),
                                                                      actionsAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30)),
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              30),
                                                                      title:
                                                                          Center(
                                                                        child:
                                                                            textWidget(
                                                                          text:
                                                                              "اضافة حساس",
                                                                          color:
                                                                              CommonColor.calendarColor,
                                                                          fontSize:
                                                                              23,
                                                                          fontFamily:
                                                                              AppDetails.cairoRegular,
                                                                        ),
                                                                      ),
                                                                      content:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          textWidget(
                                                                            text:
                                                                                "معرف الجهاز",
                                                                            color:
                                                                                CommonColor.checkedDarkColor,
                                                                            fontSize:
                                                                                23,
                                                                            fontFamily:
                                                                                AppDetails.cairoRegular,
                                                                          ),
                                                                          CommonTextFormField(
                                                                              textInputAction: TextInputAction.next,
                                                                              validator: (msg) {},
                                                                              controller: TextEditingController(),
                                                                              hintText: "",
                                                                              keyboardType: TextInputType.text),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          textWidget(
                                                                            text:
                                                                                "الرقم السري",
                                                                            color:
                                                                                CommonColor.checkedDarkColor,
                                                                            fontSize:
                                                                                23,
                                                                            fontFamily:
                                                                                AppDetails.cairoRegular,
                                                                          ),
                                                                          CommonTextFormField(
                                                                              textInputAction: TextInputAction.next,
                                                                              validator: (msg) {},
                                                                              controller: TextEditingController(),
                                                                              hintText: "",
                                                                              keyboardType: TextInputType.text),
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        CommonButton(
                                                                            elevationValue:
                                                                                5,
                                                                            buttonColor: Colors
                                                                                .white,
                                                                            buttonWidth:
                                                                                100,
                                                                            buttonHeight:
                                                                                32,
                                                                            fontSize:
                                                                                18,
                                                                            buttonFontFamily:
                                                                                AppDetails.cairoRegular,
                                                                            fontColor: CommonColor.calendarColor,
                                                                            borderSide: BorderSide(color: CommonColor.calendarColor),
                                                                            onPress: () {
                                                                              setState(() {
                                                                                sensor = true;
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            text: "نعم"),
                                                                        CommonButton(
                                                                            elevationValue:
                                                                                5,
                                                                            buttonColor: Colors
                                                                                .white,
                                                                            buttonWidth:
                                                                                100,
                                                                            buttonHeight:
                                                                                32,
                                                                            fontSize:
                                                                                18,
                                                                            buttonFontFamily:
                                                                                AppDetails.cairoRegular,
                                                                            fontColor: CommonColor.redColor,
                                                                            borderSide: BorderSide(color: CommonColor.redColor),
                                                                            onPress: () => Navigator.pop(context),
                                                                            text: "لا"),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              text: "نعم"),
                                                          CommonButton(
                                                              elevationValue: 5,
                                                              buttonColor:
                                                                  Colors.white,
                                                              buttonWidth: 100,
                                                              buttonHeight: 32,
                                                              fontSize: 18,
                                                              buttonFontFamily:
                                                                  AppDetails
                                                                      .cairoRegular,
                                                              fontColor:
                                                                  CommonColor
                                                                      .redColor,
                                                              borderSide: BorderSide(
                                                                  color: CommonColor
                                                                      .redColor),
                                                              onPress: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              text: "لا"),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              : () {
                                                  setState(() {
                                                    page = UserHome
                                                        .showMeterScreen;
                                                  });
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CommonColor.whiteColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                    blurRadius: 5,
                                                    spreadRadius: 0.10,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                border: Border.all(
                                                    color: CommonColor
                                                        .calendarLightColor)),
                                            child: ListTile(
                                              leading: Image.asset(
                                                  Assets.shared.sensorsIcon),
                                              trailing: textWidget(
                                                text: sensor == false
                                                    ? "اعداد الحساسات "
                                                    : "قراءة بيانات الحساسات ",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonButton(
                                          elevationValue: 5,
                                          buttonColor: Colors.white,
                                          buttonWidth: 100,
                                          buttonHeight: 32,
                                          fontSize: 18,
                                          buttonFontFamily:
                                              AppDetails.cairoRegular,
                                          fontColor: CommonColor.calendarColor,
                                          borderSide: BorderSide(
                                              color: CommonColor.calendarColor),
                                          onPress: () {
                                            setState(() {
                                              page = UserHome.plant;
                                            });
                                          },
                                          text: "العودة"),
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    )
                  ],
                ))));
  }

  Widget showMeterScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        gradient: LinearGradient(colors: [
          CommonColor.calendarColor,
          CommonColor.whiteColor,
        ], begin: Alignment.topCenter, end: Alignment.center),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, left: 40, right: 40),
              height: 247,
              width: 358,
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      height: 135,
                      width: 135,
                      child: CustomPaint(
                        painter: GradientBorderPainter(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white70, // Start color
                              Field5, //
                              // End color
                            ],
                          ),
                          strokeWidth: 15, // thickness of the border
                        ),
                        child: Center(
                          child: Container(
                            width: 120, // Adjust the width as needed
                            height: 120, // Adjust the height as needed
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                field5,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppDetails.cairoRegular,
                                  color: CommonColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: textWidget(
                        text: "مقياس رطوبة التربة",
                        fontSize: 26,
                        fontFamily: AppDetails.cairoRegular,
                        color: CommonColor.borderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textWidget(
              text: "معادن التربة",
              fontSize: 22,
              fontFamily: AppDetails.cairoRegular,
              color: CommonColor.fillColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 105,
                    height: 173,
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
                      color: "#ffffff".toHexa(),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 62,
                          height: 62,
                          child: CustomPaint(
                            painter: GradientBorderPainter(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white70, // Start color
                                  Field1, //
                                  // End color
                                ],
                              ),
                              strokeWidth: 5, // thickness of the border
                            ),
                            child: Center(
                              child: Container(
                                width: 120, // Adjust the width as needed
                                height: 120, // Adjust the height as needed
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    field1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: AppDetails.cairoRegular,
                                      color: CommonColor.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        textWidget(
                          text: "N",
                          fontSize: 22,
                          fontFamily: AppDetails.cairoRegular,
                          color: "#688665".toHexa(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        textWidget(
                          text: "النيتروجين",
                          fontSize: 17,
                          fontFamily: AppDetails.cairoRegular,
                          color: CommonColor.blackColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 105,
                    height: 173,
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
                      color: "#ffffff".toHexa(),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 62,
                          height: 62,
                          child: CustomPaint(
                            painter: GradientBorderPainter(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white70, // Start color
                                  Field2, //
                                  // End color
                                ],
                              ),
                              strokeWidth: 5, // thickness of the border
                            ),
                            child: Center(
                              child: Container(
                                width: 120, // Adjust the width as needed
                                height: 120, // Adjust the height as needed
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    field2,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: AppDetails.cairoRegular,
                                      color: CommonColor.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        textWidget(
                          text: "P",
                          fontSize: 22,
                          fontFamily: AppDetails.cairoRegular,
                          color: "#688665".toHexa(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        textWidget(
                          text: "الفسفور",
                          fontSize: 17,
                          fontFamily: AppDetails.cairoRegular,
                          color: CommonColor.blackColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 105,
                    height: 173,
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
                      color: "#ffffff".toHexa(),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 62,
                          height: 62,
                          child: CustomPaint(
                            painter: GradientBorderPainter(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white70, // Start color
                                  Field3, //
                                  // End color
                                ],
                              ),
                              strokeWidth: 5, // thickness of the border
                            ),
                            child: Center(
                              child: Container(
                                width: 120, // Adjust the width as needed
                                height: 120, // Adjust the height as needed
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    field3,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: AppDetails.cairoRegular,
                                      color: CommonColor.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        textWidget(
                          text: "K",
                          fontSize: 22,
                          fontFamily: AppDetails.cairoRegular,
                          color: "#688665".toHexa(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: textWidget(
                            text: "البوتاسيوم",
                            fontSize: 17,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textWidget(
              text: "حموضة التربة",
              fontSize: 22,
              fontFamily: AppDetails.cairoRegular,
              color: CommonColor.fillColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 246,
              height: 126,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                  ),
                ],
                color: "#ffffff".toHexa(),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 85,
                    width: 85,
                    child: CustomPaint(
                      painter: GradientBorderPainter(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white70, // Start color
                            Field4, //
                            // End color
                          ],
                        ),
                        strokeWidth: 15, // thickness of the border
                      ),
                      child: Center(
                        child: Text(
                          field4,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    page = UserHome.home;
                  });
                },
                child: Container(
                  width: 230,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: "#ffffff".toHexa(),
                      borderRadius: const BorderRadius.all(Radius.circular(25))),
                  child: textWidget(
                    textAlign: TextAlign.center,
                    text: "العودة الي الرئيسية",
                    fontSize: 20,
                    fontFamily: AppDetails.cairoRegular,
                    color: CommonColor.fillColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget times(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Image.asset(
                      fit: BoxFit.cover,
                      Assets.shared.SpeciaListHome,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 95),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  setState(() {
                                    page = UserHome.home;
                                  });
                                },
                                color: CommonColor.borderColor,
                              ),
                            )),
                        Container(
                          width: 322,
                          margin: const EdgeInsets.only(top: 85),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButtonFormField(
                            padding: EdgeInsets.zero,
                            items: downMenuItem1,
                            onChanged: (String? newValue) {
                              setState(() => dropDownItem1 = newValue!);
                            },
                            value: dropDownItem1,
                            decoration: InputDecoration(
                              label: textWidget(
                                text: "النبته",
                                fontFamily: AppDetails.cairoRegular,
                                fontSize: 18,
                                color: CommonColor.checkedDarkColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CommonColor.borderColor,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: CommonColor.blackColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: CommonColor.borderColor,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: CommonColor.borderColor,
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: CommonColor.borderColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            icon: Icon(
                              CupertinoIcons.chevron_down,
                              color: CommonColor.calendarColor,
                              size: 20,
                            ),
                            hint: textWidget(
                              text: "نبات لاسيليف",
                              fontFamily: AppDetails.cairoRegular,
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 357,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: _previousMonth,
                              color: CommonColor.borderColor,
                            ),
                            Text(
                              DateFormat.yMMMM().format(availableDate),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColor.borderColor),
                            ),
                            IconButton(
                              color: CommonColor.borderColor,
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: _nextMonth,
                            ),
                          ],
                        ),
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 7,
                        padding: EdgeInsets.zero,
                        children: List.generate(
                          7,
                          (index) => Center(
                            child: Text(
                              DateFormat.E().format(DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  index + 1)),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CommonColor.calendarColor),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 0,
                        thickness: 1,
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        crossAxisCount: 7,
                        children: _getDatesInMonth(availableDate).map((date) {
                          bool isSelected = date.year == availableDate.year &&
                              date.month == availableDate.month &&
                              date.day == availableDate.day;
                          return GestureDetector(
                            onTap: () => _onDateSelected(date),
                            child: Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? "#72B28A".toHexa()
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontFamily: AppDetails.cairoRegular,
                                      fontSize: 17,
                                      color: isSelected
                                          ? Colors.white
                                          : CommonColor.calendarColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    textWidget(
                      text: "مواعيد اليوم",
                      color: CommonColor.borderColor,
                      fontSize: 25,
                      fontFamily: AppDetails.cairoRegular,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                StreamBuilder<List<TimesModel>>(
                    stream: Firebase.shared.times(),
                    builder: (context, snapshot) {
                      List<TimesModel>? availableList = [];
                      if (snapshot.hasData) {
                        for (var time in snapshot.data!) {
                          if (DateFormat('EEE, M/d/y').format(time.date) == DateFormat('EEE, M/d/y').format(availableDate) && dropDownItem1 == time.plant) {
                            availableList.add(time);
                          }
                        }
                        if (availableList.isNotEmpty) {
                          availableSnackBar(availableList.last.note);
                         }
                        availableList.sort((a, b) {
                          return b.date.compareTo(a.date);
                        });

                        return Wrap(
                            children: List.generate(
                          availableList.length,
                          (index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50, top: 10),
                                child: Card(
                                    elevation: 4,
                                    surfaceTintColor: Colors.white,
                                    color: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  availableList[index].note,
                                                  style: TextStyle(
                                                      color:
                                                          "#5E875A".toHexa()),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      DateFormat('hh:mm a')
                                                          .format(availableList[
                                                                  index]
                                                              .date),
                                                      style: TextStyle(
                                                          color: "#5E875A"
                                                              .toHexa()),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                      Assets.shared.timeVector,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Firebase.shared.deleteTimes(
                                                    context,
                                                    scaffoldKey: scaffoldKey,
                                                    id: availableList[index]
                                                        .id);
                                              },
                                              child: Container(
                                                  height: 28,
                                                  width: 104,
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
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: "#FF1B1B"
                                                              .toHexa())),
                                                  child: Center(
                                                    child: Text(
                                                      'حذف',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: "#FF1B1B"
                                                              .toHexa()),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            void Function(
                                                                    void
                                                                        Function())
                                                                setState) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                        title: Stack(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topCenter,
                                                          children: [
//                                                    Image.asset(
//                                                       Assets.shared.vector,
//                                                       height: 21.88,
//                                                       width: 25,
//                                                     ),
                                                            Text(
                                                              "اضافة موعد جديد",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: "#9DBA89"
                                                                    .toHexa(),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: 322,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            85),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child:
                                                                    DropdownButtonFormField(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  items:
                                                                      downMenuItem1,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(() =>
                                                                        dropDownItem1 =
                                                                            newValue!);
                                                                  },
                                                                  value:
                                                                      dropDownItem1,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    label:
                                                                        textWidget(
                                                                      text:
                                                                          "النبته",
                                                                      fontFamily:
                                                                          AppDetails
                                                                              .cairoRegular,
                                                                      fontSize:
                                                                          18,
                                                                      color: CommonColor
                                                                          .checkedDarkColor,
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CommonColor
                                                                            .borderColor,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CommonColor
                                                                            .blackColor,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CommonColor
                                                                            .borderColor,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CommonColor
                                                                            .borderColor,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CommonColor
                                                                            .borderColor,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  icon: Icon(
                                                                    CupertinoIcons
                                                                        .chevron_down,
                                                                    color: CommonColor
                                                                        .calendarColor,
                                                                    size: 20,
                                                                  ),
                                                                  hint:
                                                                      textWidget(
                                                                    text:
                                                                        "نبات لاسيليف",
                                                                    fontFamily:
                                                                        AppDetails
                                                                            .cairoRegular,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              CommonTextFormField(
                                                                isReadyOnly:
                                                                    false,
                                                                label:
                                                                    "الري الاسبوعي",
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                validator:
                                                                    (msg) {
                                                                  return null;
                                                                },
                                                                controller:
                                                                    Field,
                                                                hintText:
                                                                    "كل ٤ ايام ",
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                'وقت التذكير بالري',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: "#688665"
                                                                      .toHexa(),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                            blurRadius:
                                                                                0.10,
                                                                            spreadRadius:
                                                                                0.10,
                                                                          ),
                                                                        ],
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child: DropdownButton<
                                                                          String>(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        alignment:
                                                                            AlignmentDirectional.center,
                                                                        iconSize:
                                                                            20,
                                                                        iconEnabledColor:
                                                                            CommonColor.calendarColor,
                                                                        value:
                                                                            _selectedAmPm,
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            _selectedAmPm =
                                                                                newValue!;
                                                                          });
                                                                        },
                                                                        items: _ampm.map<
                                                                            DropdownMenuItem<
                                                                                String>>((String
                                                                            value) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            alignment:
                                                                                AlignmentDirectional.center,
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                textWidget(
                                                                              text: value,
                                                                              fontFamily: AppDetails.cairoRegular,
                                                                              fontSize: 17,
                                                                              color: CommonColor.calendarColor,
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    ),
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
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius.circular(
                                                                              20)),
                                                                      child:
                                                                          DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            int>(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 10,
                                                                              right: 10),
                                                                          iconSize:
                                                                              20,
                                                                          iconEnabledColor:
                                                                              CommonColor.calendarColor,
                                                                          value:
                                                                              _selectedMinute,
                                                                          onChanged:
                                                                              (int? newValue) {
                                                                            setState(() {
                                                                              _selectedMinute = newValue!;
                                                                            });
                                                                          },
                                                                          items:
                                                                              _minutes.map<DropdownMenuItem<int>>((int value) {
                                                                            return DropdownMenuItem<int>(
                                                                              value: value,
                                                                              child: textWidget(
                                                                                text: value.toString().padLeft(2, '0'),
                                                                                fontFamily: AppDetails.cairoRegular,
                                                                                fontSize: 17,
                                                                                color: CommonColor.calendarColor,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      )),
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
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius.circular(
                                                                              20)),
                                                                      child:
                                                                          DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            int>(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 10,
                                                                              right: 10),
                                                                          iconSize:
                                                                              20,
                                                                          iconEnabledColor:
                                                                              CommonColor.calendarColor,
                                                                          value:
                                                                              _selectedHour,
                                                                          onChanged:
                                                                              (int? newValue) {
                                                                            setState(() {
                                                                              _selectedHour = newValue!;
                                                                            });
                                                                          },
                                                                          items:
                                                                              _hours.map<DropdownMenuItem<int>>((int value) {
                                                                            return DropdownMenuItem<int>(
                                                                              value: value,
                                                                              child: textWidget(
                                                                                text: value.toString(),
                                                                                fontFamily: AppDetails.cairoRegular,
                                                                                fontSize: 17,
                                                                                color: CommonColor.calendarColor,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      ))
                                                                ],
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
                                                                  if (Field
                                                                          .text ==
                                                                      "") {
                                                                    scaffoldKey.showTosta(
                                                                        context,
                                                                        message:
                                                                            'يرجى تعبئة جميع الحقول',
                                                                        isError:
                                                                            true);
                                                                    return;
                                                                  }
                                                                  final today =
                                                                      availableDate;
                                                                  if (_selectedAmPm ==
                                                                      'AM') {
                                                                    final fiftyDaysFromNow = today.add(Duration(
                                                                        hours:
                                                                            _selectedHour,
                                                                        minutes:
                                                                            _selectedMinute));
                                                                    Firebase.shared.updateTimes(
                                                                        context,
                                                                        scaffoldKey:
                                                                            scaffoldKey,
                                                                        uid: Firebase
                                                                            .shared
                                                                            .auth
                                                                            .currentUser!
                                                                            .uid,
                                                                        plant:
                                                                            dropDownItem1!,
                                                                        note: Field
                                                                            .text,
                                                                        date:
                                                                            fiftyDaysFromNow,
                                                                        id: availableList[index]
                                                                            .id);
                                                                  } else if (_selectedAmPm ==
                                                                      'PM') {
                                                                    final fiftyDaysFromNow = today.add(Duration(
                                                                        hours: _selectedHour +
                                                                            11,
                                                                        minutes:
                                                                            _selectedMinute +
                                                                                60));
                                                                    Firebase.shared.updateTimes(
                                                                        context,
                                                                        scaffoldKey:
                                                                            scaffoldKey,
                                                                        uid: Firebase
                                                                            .shared
                                                                            .auth
                                                                            .currentUser!
                                                                            .uid,
                                                                        plant:
                                                                            dropDownItem1!,
                                                                        note: Field
                                                                            .text,
                                                                        date:
                                                                            fiftyDaysFromNow,
                                                                        id: availableList[index]
                                                                            .id);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 22,
                                                                  width: 64,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.grey,
                                                                          offset:
                                                                              Offset(
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                          blurRadius:
                                                                              0.10,
                                                                          spreadRadius:
                                                                              0.10,
                                                                        ),
                                                                      ],
                                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                      color: Colors.white,
                                                                      border: Border.all(
                                                                        color: "#000000"
                                                                            .toHexa(),
                                                                      )),
                                                                  child: Text(
                                                                    'اضافة',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: "#000000"
                                                                            .toHexa()),
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
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.grey,
                                                                          offset:
                                                                              Offset(
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                          blurRadius:
                                                                              0.10,
                                                                          spreadRadius:
                                                                              0.10,
                                                                        ),
                                                                      ],
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color:
                                                                              "#FF1B1B".toHexa())),
                                                                  child: Text(
                                                                    'الغاء',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: "#FF1B1B"
                                                                            .toHexa()),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                                  },
                                                );
                                              },
                                              child: Container(
                                                  height: 28,
                                                  width: 104,
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
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: "#FF1B1B"
                                                              .toHexa())),
                                                  child: Center(
                                                    child: Text(
                                                      'تعديل',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: "#FF1B1B"
                                                              .toHexa()),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )));
                          },
                        ));
                      } else {
                        return const SizedBox();
                      }
                    }),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
//                            Image.asset(
//                               Assets.shared.vector,
//                               height: 21.88,
//                               width: 25,
//                             ),
                                Text(
                                  "اضافة موعد جديد",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: "#9DBA89".toHexa(),
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: 322,
                                    margin: const EdgeInsets.only(top: 85),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: DropdownButtonFormField(
                                      padding: EdgeInsets.zero,
                                      items: downMenuItem1,
                                      onChanged: (String? newValue) {
                                        setState(
                                            () => dropDownItem1 = newValue!);
                                      },
                                      value: dropDownItem1,
                                      decoration: InputDecoration(
                                        label: textWidget(
                                          text: "النبته",
                                          fontFamily: AppDetails.cairoRegular,
                                          fontSize: 18,
                                          color: CommonColor.checkedDarkColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CommonColor.borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: CommonColor.blackColor,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: CommonColor.borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: CommonColor.borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: CommonColor.borderColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        CupertinoIcons.chevron_down,
                                        color: CommonColor.calendarColor,
                                        size: 20,
                                      ),
                                      hint: textWidget(
                                        text: "نبات لاسيليف",
                                        fontFamily: AppDetails.cairoRegular,
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CommonTextFormField(
                                    isReadyOnly: false,
                                    label: "الري الاسبوعي",
                                    textInputAction: TextInputAction.done,
                                    validator: (msg) {
                                      return null;
                                    },
                                    controller: Field,
                                    hintText: "كل ٤ ايام ",
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'وقت التذكير بالري',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: "#688665".toHexa(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
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
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment:
                                                AlignmentDirectional.center,
                                            iconSize: 20,
                                            iconEnabledColor:
                                                CommonColor.calendarColor,
                                            value: _selectedAmPm,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedAmPm = newValue!;
                                              });
                                            },
                                            items: _ampm
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                value: value,
                                                child: textWidget(
                                                  text: value,
                                                  fontFamily:
                                                      AppDetails.cairoRegular,
                                                  fontSize: 17,
                                                  color:
                                                      CommonColor.calendarColor,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
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
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              iconSize: 20,
                                              iconEnabledColor:
                                                  CommonColor.calendarColor,
                                              value: _selectedMinute,
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  _selectedMinute = newValue!;
                                                });
                                              },
                                              items: _minutes
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: textWidget(
                                                    text: value
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    fontSize: 17,
                                                    color: CommonColor
                                                        .calendarColor,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )),
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
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              iconSize: 20,
                                              iconEnabledColor:
                                                  CommonColor.calendarColor,
                                              value: _selectedHour,
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  _selectedHour = newValue!;
                                                });
                                              },
                                              items: _hours
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: textWidget(
                                                    text: value.toString(),
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    fontSize: 17,
                                                    color: CommonColor
                                                        .calendarColor,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (Field!.text == "") {
                                        scaffoldKey.showTosta(context,
                                            message: 'يرجى تعبئة جميع الحقول',
                                            isError: true);
                                        return;
                                      }
                                      final today = availableDate;
                                      if (_selectedAmPm == 'AM') {
                                        final fiftyDaysFromNow = today.add(
                                            Duration(
                                                hours: _selectedHour,
                                                minutes: _selectedMinute));
                                        Firebase.shared.createTimes(context,
                                            scaffoldKey: scaffoldKey,
                                            uid: Firebase
                                                .shared.auth.currentUser!.uid,
                                            plant: dropDownItem1!,
                                            note: Field!.text,
                                            date: fiftyDaysFromNow);
                                      } else if (_selectedAmPm == 'PM') {
                                        final fiftyDaysFromNow = today.add(
                                            Duration(
                                                hours: _selectedHour + 11,
                                                minutes: _selectedMinute + 60));
                                        Firebase.shared.createTimes(context,
                                            scaffoldKey: scaffoldKey,
                                            uid: Firebase
                                                .shared.auth.currentUser!.uid,
                                            plant: dropDownItem1!,
                                            note: Field!.text,
                                            date: fiftyDaysFromNow);
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
                                            color: "#000000".toHexa(),
                                          )),
                                      child: Text(
                                        'اضافة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: "#000000".toHexa()),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: "#FF1B1B".toHexa())),
                                      child: Text(
                                        'الغاء',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: "#FF1B1B".toHexa()),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: Container(
                      height: 31,
                      width: 172,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border: Border.all(
                            color: "#9DBA89".toHexa(),
                          )),
                      child: Center(
                        child: Text(
                          'اضافة موعد جديد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: "#688665".toHexa()),
                        ),
                      )),
                ),
                const SizedBox(height: 25),
              ])),
    ));
  }

  availableSnackBar(note){
    Future.delayed(const Duration(seconds: 1), () {
      if (availablebool == true){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            iconRotationAngle: 0,
            textAlign: TextAlign.right,
            iconPositionLeft: 10,
            iconPositionTop: 10,
            icon: Icon(
              Icons.watch_later_outlined,
              color: CommonColor.calendarColor,
            ),
            backgroundColor: CommonColor.whiteColor,
            textStyle: TextStyle(
                color: CommonColor.checkedDarkColor,
                fontSize: 16,
                fontFamily: AppDetails.cairoRegular),
            message:
            "🌱  لديك موعد  ${note}",
          ),
        );
        setState(() {
          availablebool = false;
        });
      } else {
        print(availablebool);
        setState(() {
          availablebool = false;
        });
      }
    });
  }

  Widget rejectedRequest(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.backgroundUser,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    left: 20,
                    top: 180,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            page = UserHome.appointments;
                          });
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: CommonColor.calendarColor,
                          size: 30,
                        ))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 170, right: 16.0),
                      child: Stack(
                        children: [
//                          Image.asset(
//                             Assets.shared.vector,
//                             height: 21.88,
//                             width: 25,
//                           ),
                          textWidget(
                            text: "الطلبات المرفوضة",
                            color: CommonColor.calendarColor,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 30,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Expanded(
                child: FutureBuilder<List<ReportsModel>>(
                    future: Firebase.shared.userReports(
                        uid: Firebase.shared.auth.currentUser!.uid,
                        status: Status.cancel),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ReportsModel>? items = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                elevation: 6,
                                color: CommonColor.whiteColor,
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: CommonColor.whiteColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, right: 15, left: 15, bottom: 0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        trailing: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actionsAlignment:
                                                      MainAxisAlignment.center,
                                                  actionsPadding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  title: Center(
                                                    child: textWidget(
                                                      text: "سبب رفض الجلسة",
                                                      color: CommonColor
                                                          .calendarColor,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  // titlePadding:const EdgeInsets.only(top: 10),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 20,
                                                          bottom: 20),
                                                  content: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          // Border radius for the container
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 2.0,
                                                              spreadRadius: 0.0,
                                                              offset: Offset(0,
                                                                  2), // shadow direction: bottom right
                                                            ),
                                                          ],
                                                        ),
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          maxLines: 6,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .top,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          validator: (value) {
                                                            return null;
                                                          },
                                                          controller:
                                                              TextEditingController(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                AppDetails
                                                                    .cairoMedium,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: CommonColor
                                                                .blackColor,
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          onChanged: (value) {},
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle: const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontFamily:
                                                                    AppDetails
                                                                        .cairoRegular,
                                                                fontSize: 18),
                                                            hintText:
                                                                items[index]
                                                                    .rejected,
                                                            filled: true,
                                                            fillColor:
                                                                CommonColor
                                                                    .whiteColor,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        10),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily: AppDetails
                                                                  .cairoRegular,
                                                              fontSize: 17,
                                                              color: CommonColor
                                                                  .checkedDarkColor,
                                                            ),
                                                            counterText: "",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CommonColor
                                                                    .calendarColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CommonColor
                                                                    .calendarColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CommonColor
                                                                    .calendarColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CommonColor
                                                                    .calendarColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CommonColor
                                                                    .redColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    CommonButton(
                                                        elevationValue: 5,
                                                        buttonColor:
                                                            Colors.white,
                                                        buttonWidth: 100,
                                                        buttonHeight: 32,
                                                        fontSize: 18,
                                                        buttonFontFamily:
                                                            AppDetails
                                                                .cairoMedium,
                                                        fontColor: CommonColor
                                                            .calendarColor,
                                                        borderSide: BorderSide(
                                                            color: CommonColor
                                                                .calendarColor),
                                                        onPress: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        text: "انتهاء"),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: CommonColor.redColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(0.0, 4.0),
                                                  blurRadius: 5,
                                                  spreadRadius: 0.10,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 2),
                                              child: Text(
                                                "سبب الرفض",
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppDetails.cairoMedium,
                                                  color: CommonColor.whiteColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        leading: FutureBuilder<UserModel>(
                                            future: Firebase.shared.userByUid(
                                                uid: items[index]
                                                    .uidSpecialist!),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                UserModel? user = snapshot.data;
                                                return RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                        text: "بيانات الموعد ",
                                                        style: TextStyle(
                                                          color: CommonColor
                                                              .calendarColor,
                                                          fontFamily: AppDetails
                                                              .cairoRegular,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              "${user!.name} ${user.last}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily: AppDetails
                                                                .cairoRegular,
                                                            fontSize: 17,
                                                          )),
                                                    ]));
                                              } else {
                                                return RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                        text: "بيانات الموعد",
                                                        style: TextStyle(
                                                          color: CommonColor
                                                              .calendarColor,
                                                          fontFamily: AppDetails
                                                              .cairoRegular,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                          text: "  م. ",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily: AppDetails
                                                                .cairoRegular,
                                                            fontSize: 17,
                                                          )),
                                                    ]));
                                              }
                                            }),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textWidget(
                                            text: DateFormat('EEEE').format(
                                                items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                          textWidget(
                                            text: DateFormat('d MMM yyyy')
                                                .format(
                                                    items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                          textWidget(
                                            text: DateFormat('hh:mm a').format(
                                                items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                        ],
                                      ),
                                      textWidget(
                                        fontFamily: AppDetails.cairoMedium,
                                        color: CommonColor.calendarColor,
                                        text:
                                            items[index].report == Report.online
                                                ? 'اون لاين'
                                                : 'زيارة ميدانية',
                                        fontSize: 17,
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(Assets.shared.plantpotTwo),
                Image.asset(Assets.shared.plantpotThree),
                Image.asset(Assets.shared.plantpotOne),
              ],
            ),
          ])),
    );
  }

  Widget appointments(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.backgroundUser,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    left: 20,
                    top: 180,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            page = UserHome.home;
                          });
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: CommonColor.calendarColor,
                          size: 30,
                        ))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 170, right: 16.0),
                      child: Stack(
                        children: [
//                          Image.asset(
//                             Assets.shared.vector,
//                             height: 21.88,
//                             width: 25,
//                           ),
                          textWidget(
                            text: "المواعيد المجدولة",
                            color: CommonColor.calendarColor,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 30,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Expanded(
                child: FutureBuilder<List<ReportsModel>>(
                    future: Firebase.shared.userReports(
                        uid: Firebase.shared.auth.currentUser!.uid,
                        status: Status.active),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ReportsModel>? items = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                elevation: 6,
                                color: CommonColor.whiteColor,
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: CommonColor.whiteColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, right: 15, left: 15, bottom: 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "بيانات الموعد ",
                                                  style: TextStyle(
                                                    color: CommonColor
                                                        .calendarColor,
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ])),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return sessionAlertDialogWidget(
                                                        reports: items[index],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: CommonColor
                                                        .calendarLightColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset:
                                                            Offset(0.0, 4.0),
                                                        blurRadius: 5,
                                                        spreadRadius: 0.10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      "اعادة جدولة",
                                                      style: TextStyle(
                                                        fontFamily: AppDetails
                                                            .cairoMedium,
                                                        color: CommonColor
                                                            .checkedDarkColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Center(
                                                        child: AlertDialog(
                                                          actionsPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 20),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          title: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.asset(
                                                                Assets.shared
                                                                    .cancel),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 20,
                                                                  bottom: 20),
                                                          content: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20.0),
                                                                child:
                                                                    textWidget(
                                                                  text:
                                                                      "هل انت متاكد من الغاء الجلسة؟",
                                                                  color: CommonColor
                                                                      .titleColor,
                                                                  fontFamily:
                                                                      AppDetails
                                                                          .cairoRegular,
                                                                  fontSize: 24,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          50),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: "#365133"
                                                                        .toHexa()),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: CommonColor
                                                                    .whiteColor,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500,
                                                                    blurRadius:
                                                                        2.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3),
                                                                  )
                                                                ],
                                                              ),
                                                              child:
                                                                  IntrinsicHeight(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Firebase.shared.updateReports(
                                                                            context,
                                                                            scaffoldKey:
                                                                                scaffoldKey,
                                                                            date:
                                                                                items[index].createdDate,
                                                                            phone: items[index].phone!,
                                                                            place: items[index].place!,
                                                                            title: items[index].title!,
                                                                            uidUser: items[index].uidUser!,
                                                                            nameUser: items[index].nameUser!,
                                                                            idUser: items[index].idUser!,
                                                                            uidSpecialist: items[index].uidSpecialist!,
                                                                            idSpecialist: items[index].idSpecialist!,
                                                                            note: items[index].note!,
                                                                            id: items[index].id!,
                                                                            rejected: items[index].rejected!,
                                                                            status: Status.cancel,
                                                                            report: items[index].report);
                                                                      },
                                                                      child:
                                                                          textWidget(
                                                                        fontFamily:
                                                                            AppDetails.cairoRegular,
                                                                        fontSize:
                                                                            15,
                                                                        color: "#365133"
                                                                            .toHexa(),
                                                                        text:
                                                                            "ارسال",
                                                                      ),
                                                                    ),
                                                                    // ----vertical
                                                                    Center(
                                                                      child:
                                                                          VerticalDivider(
                                                                        color: "#365133"
                                                                            .toHexa(),
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () =>
                                                                          Navigator.pop(
                                                                              context),
                                                                      child:
                                                                          textWidget(
                                                                        fontFamily:
                                                                            AppDetails.cairoRegular,
                                                                        text:
                                                                            "العودة",
                                                                        fontSize:
                                                                            15,
                                                                        color: "#365133"
                                                                            .toHexa(),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: CommonColor
                                                        .calendarLightColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset:
                                                            Offset(0.0, 4.0),
                                                        blurRadius: 5,
                                                        spreadRadius: 0.10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      "الغاء",
                                                      style: TextStyle(
                                                        fontFamily: AppDetails
                                                            .cairoMedium,
                                                        color: CommonColor
                                                            .checkedDarkColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textWidget(
                                            text: DateFormat('EEEE').format(
                                                items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                          textWidget(
                                            text: DateFormat('d MMM yyyy')
                                                .format(
                                                    items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                          textWidget(
                                            text: DateFormat('hh:mm a').format(
                                                items[index].createdDate),
                                            color: Colors.grey,
                                            fontFamily: AppDetails.cairoRegular,
                                            fontSize: 17,
                                          ),
                                        ],
                                      ),
                                      textWidget(
                                        fontFamily: AppDetails.cairoMedium,
                                        color: CommonColor.calendarColor,
                                        text:
                                            items[index].report == Report.online
                                                ? 'اون لاين'
                                                : 'زيارة ميدانية',
                                        fontSize: 17,
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    })),
            InkWell(
              onTap: () {
                setState(() {
                  page = UserHome.rejectedRequest;
                });
              },
              child: Container(
                  width: 271,
                  height: 56,
                  decoration: BoxDecoration(
                    color: CommonColor.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 2,
                        spreadRadius: 0.10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "الطلبات المرفوضة",
                        style: TextStyle(
                          fontFamily: AppDetails.cairoMedium,
                          color: CommonColor.calendarColor,
                          fontSize: 17,
                        ),
                      ),
                      FutureBuilder<List<ReportsModel>>(
                          future: Firebase.shared.userReports(
                              uid: Firebase.shared.auth.currentUser!.uid,
                              status: Status.cancel),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ReportsModel>? items = snapshot.data!;
                              return Stack(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: CommonColor.buttonColor,
                                    size: 35,
                                  ),
                                  Visibility(
                                    visible: items.isNotEmpty,
                                    child: Positioned(
                                        top: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          child: Text(
                                            items.length.toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  CommonColor.checkedDarkColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            } else {
                              return Icon(
                                Icons.notifications,
                                color: CommonColor.buttonColor,
                                size: 35,
                              );
                            }
                          })
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(Assets.shared.plantpotTwo),
                Image.asset(Assets.shared.plantpotThree),
                Image.asset(Assets.shared.plantpotOne),
              ],
            ),
          ])),
    );
  }

  Widget Community(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    Assets.shared.Community,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Container(
                            width: 354,
                            height: 151,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#FFFFFF".toHexa(),
                                  offset: const Offset(
                                    10.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#FFFFFF".toHexa(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget(
                                  text: "اهلا بك في\nمجتمع النباتات",
                                  color: CommonColor.calendarColor,
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 26,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  Assets.shared.ecology,
                                ),
                              ],
                            ),
                          ))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            setState(() {
                              page = UserHome.home;
                            });
                          },
                          color: CommonColor.borderColor,
                        ),
                        padding: const EdgeInsets.only(top: 140),
                      )),
                ],
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      page = UserHome.exchange;
                    });
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        Assets.shared.exchange,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 130),
                          child: Container(
                              width: 136,
                              height: 42,
                              decoration: BoxDecoration(
                                color: "#FFFFFF".toHexa(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Center(
                                child: textWidget(
                                  text: "تبادل النباتات",
                                  color: CommonColor.calendarColor,
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 20,
                                ),
                              )))
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      page = UserHome.Share;
                    });
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        Assets.shared.Share,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 130, right: 158),
                          child: Container(
                              width: 136,
                              height: 42,
                              decoration: BoxDecoration(
                                color: "#FFFFFF".toHexa(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Center(
                                child: textWidget(
                                  text: "شاركنا خبراتك",
                                  color: CommonColor.calendarColor,
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 20,
                                ),
                              )))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget exchange(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.Community,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 130),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 62,
                        decoration: BoxDecoration(
                          color: "#FFFFFF".toHexa(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: textWidget(
                            text: exchangePlant == false
                                ? "تبادل النباتات"
                                : "الاعتناء بنباتات",
                            color: CommonColor.calendarColor,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 26,
                          ),
                        ))),
                Positioned(
                    left: 5,
                    top: 90,
                    child: IconButton(
                        onPressed: () {
                          if (exchangePlant == false) {
                            setState(() {
                              page = UserHome.Community;
                            });
                          } else {
                            setState(() {
                              exchangePlant = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: CommonColor.calendarColor,
                          size: 30,
                        ))),
              ],
            ),
            Visibility(
                visible: exchangePlant == false,
                child: Expanded(
                    child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            exchangePlant = true;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 335,
                              height: 99,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    blurRadius: 0.10,
                                    spreadRadius: 0.10,
                                  ),
                                ],
                                color: "#FFFFFF".toHexa(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                child: textWidget(
                                  text: " الاعتناء بنباتات الغير",
                                  color: CommonColor.calendarColor,
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 270),
                                child: Image.asset(Assets.shared.leaf)),
                          ],
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                  onWillPop: () async => false,
                                  child: AlertDialog(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    title: Center(
                                      child: textWidget(
                                        text: "طلب الاعتناء بنباتاتي",
                                        color: CommonColor.calendarColor,
                                        fontFamily: AppDetails.cairoRegular,
                                        fontSize: 26,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonTextFormField(
                                            isReadyOnly: false,
                                            label: "عدد النباتات",
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (msg) {
                                              return null;
                                            },
                                            controller: plants,
                                            hintText: "10  نباتات",
                                            keyboardType: TextInputType.text,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CommonTextFormField(
                                            isReadyOnly: false,
                                            label: "مده الاعتناء ",
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (msg) {
                                              return null;
                                            },
                                            controller: durationPlants,
                                            hintText: "3 اسابيع",
                                            keyboardType: TextInputType.text,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CommonTextFormField(
                                            maxLines: 6,
                                            isReadyOnly: false,
                                            label: "ملاحظات",
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (msg) {
                                              return null;
                                            },
                                            controller: notePlants,
                                            hintText: " لا يوجد",
                                            keyboardType: TextInputType.text,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CommonTextFormField(
                                            isReadyOnly: false,
                                            label: "رقم التواصل ",
                                            textInputAction:
                                                TextInputAction.done,
                                            validator: (msg) {
                                              return null;
                                            },
                                            controller: number,
                                            hintText: "  05********",
                                            keyboardType: TextInputType.text,
                                          )
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
                                              if (plants.text == '' ||
                                                  durationPlants.text == '' ||
                                                  notePlants.text == " " ||
                                                  number.text == "") {
                                                scaffoldKey.showTosta(context,
                                                    message: 'هناك خطأ ما',
                                                    isError: true);
                                                return;
                                              }
                                              Firebase.shared.createCaring(
                                                  context,
                                                  scaffoldKey: scaffoldKey,
                                                  plants: plants.text,
                                                  Duration: durationPlants.text,
                                                  note: notePlants.text,
                                                  number: number.text,
                                                  uid: Firebase.shared.auth
                                                      .currentUser!.uid);
                                            },
                                            child: Container(
                                                width: 84,
                                                height: 37,
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
                                                            Radius.circular(
                                                                20)),
                                                    color: "#FFFFFF".toHexa(),
                                                    border: Border.all(
                                                      color: "#9DBA89".toHexa(),
                                                    )),
                                                child: Center(
                                                  child: textWidget(
                                                    text: "ارسال طلب",
                                                    color: CommonColor
                                                        .calendarColor,
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    fontSize: 16,
                                                  ),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                                width: 84,
                                                height: 37,
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
                                                            Radius.circular(
                                                                20)),
                                                    color: "#FFFFFF".toHexa(),
                                                    border: Border.all(
                                                      color: "#9DBA89".toHexa(),
                                                    )),
                                                child: Center(
                                                  child: textWidget(
                                                    text: "الغاء",
                                                    color: CommonColor
                                                        .calendarColor,
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    fontSize: 16,
                                                  ),
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ));
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 335,
                              height: 99,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: const Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    blurRadius: 0.10,
                                    spreadRadius: 0.10,
                                  ),
                                ],
                                color: "#FFFFFF".toHexa(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                child: textWidget(
                                  text: "طلب الاعتناء بنباتاتي",
                                  color: CommonColor.calendarColor,
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Image.asset(Assets.shared.leaf1),
                          ],
                        )),
                  ],
                ))),
            Visibility(
                visible: exchangePlant,
                child: Expanded(
                    child: FutureBuilder<List<CaringModel>>(
                        future: Firebase.shared.caring(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<CaringModel>? Caring = snapshot.data!;
                            return ListView.builder(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              shrinkWrap: true,
                              itemCount: Caring.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 6,
                                    color: CommonColor.whiteColor,
                                    shadowColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          right: 10,
                                          top: 20,
                                          bottom: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              FutureBuilder<UserModel>(
                                                  future: Firebase.shared
                                                      .userByUid(
                                                          uid: Caring[index]
                                                              .uid),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      UserModel? user =
                                                          snapshot.data;
                                                      return CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: user!.image != ""
                                                            ? Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(user
                                                                            .image),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              )
                                                            : Icon(
                                                                Icons.person,
                                                                size: 52,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                      );
                                                    } else {
                                                      return CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 52,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '  طلب الاعتناء  ',
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .borderColor,
                                                        fontSize: 15),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "  عدد النباتات  :  ${Caring[index].plants}",
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .black12Color,
                                                            fontSize: 13),
                                                      ),
                                                      Text(
                                                        "  المده  :  ${Caring[index].Duration}",
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .black12Color,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "  الملاحظات  :${Caring[index].note}",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .black12Color,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () async =>
                                                              false,
                                                          child: AlertDialog(
                                                            surfaceTintColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Stack(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .topCenter,
                                                              children: [
                                                                Image.asset(
                                                                  Assets.shared
                                                                      .heart,
                                                                  //four
                                                                  width: 180,
                                                                  height: 200,
                                                                ),
                                                                Image.asset(
                                                                  Assets.shared
                                                                      .lily,
                                                                  //Cr
                                                                  width: 100,
                                                                  height: 100,
                                                                ),
                                                              ],
                                                            ),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  textWidget(
                                                                    text:
                                                                        "نتمنى ان تكون تجربة متميزة!",
                                                                    color: CommonColor
                                                                        .calendarColor,
                                                                    fontFamily:
                                                                        AppDetails
                                                                            .cairoRegular,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  CommonTextFormField(
                                                                    isReadyOnly:
                                                                        true,
                                                                    label:
                                                                        "تواصل مع الرقم التالي",
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .done,
                                                                    validator:
                                                                        (msg) {
                                                                      return null;
                                                                    },
                                                                    controller:
                                                                        TextEditingController(),
                                                                    hintText: Caring[
                                                                            index]
                                                                        .number,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                  )
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
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Container(
                                                                        width: 84,
                                                                        height: 37,
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
                                                                            color: "#FFFFFF".toHexa(),
                                                                            border: Border.all(
                                                                              color: "#9DBA89".toHexa(),
                                                                            )),
                                                                        child: Center(
                                                                          child:
                                                                              textWidget(
                                                                            text:
                                                                                "موافق",
                                                                            color:
                                                                                CommonColor.calendarColor,
                                                                            fontFamily:
                                                                                AppDetails.cairoRegular,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        )),
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
                                                                        width: 84,
                                                                        height: 37,
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
                                                                            color: "#FFFFFF".toHexa(),
                                                                            border: Border.all(
                                                                              color: "#9DBA89".toHexa(),
                                                                            )),
                                                                        child: Center(
                                                                          child:
                                                                              textWidget(
                                                                            text:
                                                                                "الغاء",
                                                                            color:
                                                                                CommonColor.calendarColor,
                                                                            fontFamily:
                                                                                AppDetails.cairoRegular,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        )),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ));
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                    width: 92,
                                                    height: 35,
                                                    color: CommonColor
                                                        .calendarLightColor,
                                                    child: Center(
                                                      child: textWidget(
                                                        text: "الاعتناء",
                                                        color: CommonColor
                                                            .checkedDarkColor,
                                                        fontFamily: AppDetails
                                                            .cairoRegular,
                                                        fontSize: 13,
                                                      ),
                                                    )),
                                              ))
                                        ],
                                      ),
                                    ));
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        }))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(Assets.shared.plantpotTwo),
                Image.asset(Assets.shared.plantpotThree),
                Image.asset(Assets.shared.plantpotOne),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Share(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.Share,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.only(top: 130),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                          text: questions == false ? "شاركنا خبراتك" : "اسئلتي",
                          color: CommonColor.borderColor,
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 30,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: questions == false
                                    ? () {
                                        setState(() {
                                          questions = true;
                                        });
                                      }
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return WillPopScope(
                                                onWillPop: () async => false,
                                                child: AlertDialog(
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  backgroundColor: Colors.white,
                                                  title: Center(
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      children: [
                                                        //                                                   Image.asset(
                                                        //                                                       Assets.shared.vector,
                                                        //                                                     ),
                                                        textWidget(
                                                          text:
                                                              "ارسال سؤال جديد",
                                                          color: CommonColor
                                                              .checkedDarkColor,
                                                          fontFamily: AppDetails
                                                              .cairoRegular,
                                                          fontSize: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        CommonTextFormField(
                                                          isReadyOnly: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          validator: (msg) {
                                                            return null;
                                                          },
                                                          controller:
                                                              questionsSend,
                                                          hintText:
                                                              'اكتب سؤالك هنا...',
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          maxLines: 6,
                                                        )
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
                                                            if (questionsSend
                                                                    .text ==
                                                                '') {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                      'هناك خطأ ما',
                                                                  isError:
                                                                      true);
                                                              return;
                                                            }
                                                            Firebase.shared.createQuestions(
                                                                context,
                                                                scaffoldKey:
                                                                    scaffoldKey,
                                                                questions:
                                                                    questionsSend
                                                                        .text,
                                                                uid: Firebase
                                                                    .shared
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                              width: 84,
                                                              height: 37,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                      blurRadius:
                                                                          0.10,
                                                                      spreadRadius:
                                                                          0.10,
                                                                    ),
                                                                  ],
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      color: "#FFFFFF"
                                                                          .toHexa(),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: "#9DBA89"
                                                                            .toHexa(),
                                                                      )),
                                                              child: Center(
                                                                child:
                                                                    textWidget(
                                                                  text: "ارسال",
                                                                  color: CommonColor
                                                                      .calendarColor,
                                                                  fontFamily:
                                                                      AppDetails
                                                                          .cairoRegular,
                                                                  fontSize: 16,
                                                                ),
                                                              )),
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
                                                              width: 84,
                                                              height: 37,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                      blurRadius:
                                                                          0.10,
                                                                      spreadRadius:
                                                                          0.10,
                                                                    ),
                                                                  ],
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      color: "#FFFFFF"
                                                                          .toHexa(),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: "#9DBA89"
                                                                            .toHexa(),
                                                                      )),
                                                              child: Center(
                                                                child:
                                                                    textWidget(
                                                                  text: "الغاء",
                                                                  color: CommonColor
                                                                      .calendarColor,
                                                                  fontFamily:
                                                                      AppDetails
                                                                          .cairoRegular,
                                                                  fontSize: 16,
                                                                ),
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ));
                                          },
                                        );
                                      },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      CommonColor.calendarLightColor,
                                  child: Image.asset(
                                    questions == false
                                        ? Assets.shared.a9fr_email
                                        : Assets.shared.red_add,
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    page = UserHome.Community;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      CommonColor.calendarLightColor,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                        visible: questions,
                        child: Expanded(
                          child: FutureBuilder<List<QuestionsModel>>(
                              future: Firebase.shared.questionByUid(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<QuestionsModel>? question =
                                      snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: question.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          elevation: 6,
                                          color: CommonColor.whiteColor,
                                          shadowColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 20,
                                                bottom: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    FutureBuilder<UserModel>(
                                                        future: Firebase.shared
                                                            .userByUid(
                                                                uid: question[
                                                                        index]
                                                                    .uid),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            UserModel? user =
                                                                snapshot.data;
                                                            return CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child:
                                                                  user!.image !=
                                                                          ""
                                                                      ? Container(
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.cover)),
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              52,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .secondary,
                                                                        ),
                                                            );
                                                          } else {
                                                            return CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 52,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        question[index]
                                                            .Questions,
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .borderColor,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: RawChip(
                                                      backgroundColor: CommonColor
                                                          .calendarLightColor,
                                                      selectedColor: CommonColor
                                                          .whiteColor,
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                        side: const BorderSide(
                                                            color: Colors.white,
                                                            width: 0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      elevation: 0,
                                                      label: isSelected(
                                                              question[index]
                                                                  .id!)
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color: CommonColor
                                                                  .calendarLightColor,
                                                            )
                                                          : textWidget(
                                                              text:
                                                                  "    الردود    ",
                                                              color: CommonColor
                                                                  .checkedDarkColor,
                                                              fontFamily: AppDetails
                                                                  .cairoRegular,
                                                              fontSize: 13,
                                                            ),
                                                      selected: isSelected(
                                                          question[index].id!),
                                                      showCheckmark: false,
                                                      pressElevation: 0,
                                                      onSelected: (bool value) {
                                                        if (isSelected(
                                                                question[index]
                                                                    .id!) ==
                                                            true) {
                                                          toggleSelected('');
                                                        } else {
                                                          toggleSelected(
                                                              question[index]
                                                                  .id!);
                                                        }
                                                      },
                                                    )),
                                                Visibility(
                                                    visible: isSelected(
                                                        question[index].id),
                                                    child: FutureBuilder<
                                                            List<
                                                                QuestionsModel>>(
                                                        future: Firebase.shared
                                                            .replyQuestionsGet(
                                                                doc: question[
                                                                        index]
                                                                    .id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            List<QuestionsModel>?
                                                                replyQuestionsGet =
                                                                snapshot.data!;
                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 0.0,
                                                                      right: 0),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  replyQuestionsGet
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                40,
                                                                            right:
                                                                                40,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            FutureBuilder<UserModel>(
                                                                                future: Firebase.shared.userByUid(uid: replyQuestionsGet[index].uid),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    UserModel? replyQuestionsGetuser = snapshot.data;
                                                                                    return CircleAvatar(
                                                                                      radius: 15,
                                                                                      backgroundColor: Colors.white,
                                                                                      child: replyQuestionsGetuser!.image != ""
                                                                                          ? Container(
                                                                                              decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(replyQuestionsGetuser.image), fit: BoxFit.cover)),
                                                                                            )
                                                                                          : Icon(
                                                                                              Icons.person,
                                                                                              size: 52,
                                                                                              color: Theme.of(context).colorScheme.secondary,
                                                                                            ),
                                                                                    );
                                                                                  } else {
                                                                                    return CircleAvatar(
                                                                                      radius: 15,
                                                                                      backgroundColor: Colors.white,
                                                                                      child: Icon(
                                                                                        Icons.person,
                                                                                        size: 52,
                                                                                        color: Theme.of(context).colorScheme.secondary,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                }),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Flexible(
                                                                              child: Text(
                                                                                replyQuestionsGet[index].Questions,
                                                                                style: TextStyle(color: CommonColor.borderColor, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            return const SizedBox();
                                                          }
                                                        })),
                                                Visibility(
                                                    visible: isSelected(
                                                        question[index].id),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: 220,
                                                            child:
                                                                TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'الرد...',
                                                              ),
                                                              controller:
                                                                  replyQuestions,
                                                            )),
                                                        InkWell(
                                                          onTap: () {
                                                            if (replyQuestions
                                                                    .text ==
                                                                "") {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                      'هناك خطأ ما',
                                                                  isError:
                                                                      true);
                                                              return;
                                                            }
                                                            Firebase.shared.replyQuestions(
                                                                context,
                                                                scaffoldKey:
                                                                    scaffoldKey,
                                                                questions:
                                                                    replyQuestions
                                                                        .text,
                                                                uid: Firebase
                                                                    .shared
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid,
                                                                doc: question[
                                                                        index]
                                                                    .id);
                                                            setState(() {
                                                              replyQuestions
                                                                  .text = "";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 99,
                                                            height: 52,
                                                            color: CommonColor
                                                                .buttonColor,
                                                            child: Center(
                                                              child: textWidget(
                                                                text: "ارسال",
                                                                color: CommonColor
                                                                    .checkedDarkColor,
                                                                fontFamily:
                                                                    AppDetails
                                                                        .cairoRegular,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ));
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        )),
                    Visibility(
                        visible: questions == false,
                        child: Expanded(
                          child: FutureBuilder<List<QuestionsModel>>(
                              future: Firebase.shared.question(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<QuestionsModel>? question =
                                      snapshot.data!;
                                  return ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 0.0, right: 0),
                                    shrinkWrap: true,
                                    itemCount: question.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          elevation: 6,
                                          color: CommonColor.whiteColor,
                                          shadowColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 20,
                                                bottom: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            top: 20,
                                                            bottom: 0),
                                                    child: Row(
                                                      children: [
                                                        FutureBuilder<
                                                                UserModel>(
                                                            future: Firebase
                                                                .shared
                                                                .userByUid(
                                                                    uid: question[
                                                                            index]
                                                                        .uid),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                UserModel?
                                                                    user =
                                                                    snapshot
                                                                        .data;
                                                                return CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  child: user!.image !=
                                                                          ""
                                                                      ? Container(
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.cover)),
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              52,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .secondary,
                                                                        ),
                                                                );
                                                              } else {
                                                                return CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    size: 52,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary,
                                                                  ),
                                                                );
                                                              }
                                                            }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            question[index]
                                                                .Questions,
                                                            style: TextStyle(
                                                                color: CommonColor
                                                                    .borderColor,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: RawChip(
                                                      backgroundColor: CommonColor
                                                          .calendarLightColor,
                                                      selectedColor: CommonColor
                                                          .whiteColor,
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                        side: const BorderSide(
                                                            color: Colors.white,
                                                            width: 0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      elevation: 0,
                                                      label: isSelected(
                                                              question[index]
                                                                  .id!)
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color: CommonColor
                                                                  .calendarLightColor,
                                                            )
                                                          : textWidget(
                                                              text:
                                                                  "    الرد    ",
                                                              color: CommonColor
                                                                  .checkedDarkColor,
                                                              fontFamily: AppDetails
                                                                  .cairoRegular,
                                                              fontSize: 13,
                                                            ),
                                                      selected: isSelected(
                                                          question[index].id!),
                                                      showCheckmark: false,
                                                      pressElevation: 0,
                                                      onSelected: (bool value) {
                                                        if (isSelected(
                                                                question[index]
                                                                    .id!) ==
                                                            true) {
                                                          toggleSelected('');
                                                        } else {
                                                          toggleSelected(
                                                              question[index]
                                                                  .id!);
                                                        }
                                                      },
                                                    )),
                                                Visibility(
                                                    visible: isSelected(
                                                        question[index].id),
                                                    child: FutureBuilder<
                                                            List<
                                                                QuestionsModel>>(
                                                        future: Firebase.shared
                                                            .replyQuestionsGet(
                                                                doc: question[
                                                                        index]
                                                                    .id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            List<QuestionsModel>?
                                                                replyQuestionsGet =
                                                                snapshot.data!;
                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 0.0,
                                                                      right: 0),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  replyQuestionsGet
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                40,
                                                                            right:
                                                                                40,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            FutureBuilder<UserModel>(
                                                                                future: Firebase.shared.userByUid(uid: replyQuestionsGet[index].uid),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    UserModel? replyQuestionsGetuser = snapshot.data;
                                                                                    return CircleAvatar(
                                                                                      radius: 15,
                                                                                      backgroundColor: Colors.white,
                                                                                      child: replyQuestionsGetuser!.image != ""
                                                                                          ? Container(
                                                                                              decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(replyQuestionsGetuser.image), fit: BoxFit.cover)),
                                                                                            )
                                                                                          : Icon(
                                                                                              Icons.person,
                                                                                              size: 52,
                                                                                              color: Theme.of(context).colorScheme.secondary,
                                                                                            ),
                                                                                    );
                                                                                  } else {
                                                                                    return CircleAvatar(
                                                                                      radius: 15,
                                                                                      backgroundColor: Colors.white,
                                                                                      child: Icon(
                                                                                        Icons.person,
                                                                                        size: 52,
                                                                                        color: Theme.of(context).colorScheme.secondary,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                }),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Flexible(
                                                                              child: Text(
                                                                                replyQuestionsGet[index].Questions,
                                                                                style: TextStyle(color: CommonColor.borderColor, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            return const SizedBox();
                                                          }
                                                        })),
                                                Visibility(
                                                    visible: isSelected(
                                                        question[index].id),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: 220,
                                                            child:
                                                                TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'اضف تعليق...',
                                                              ),
                                                              controller:
                                                                  replyQuestions,
                                                            )),
                                                        InkWell(
                                                          onTap: () {
                                                            if (replyQuestions
                                                                    .text ==
                                                                "") {
                                                              scaffoldKey.showTosta(
                                                                  context,
                                                                  message:
                                                                      'هناك خطأ ما',
                                                                  isError:
                                                                      true);
                                                              return;
                                                            }
                                                            Firebase.shared.replyQuestions(
                                                                context,
                                                                scaffoldKey:
                                                                    scaffoldKey,
                                                                questions:
                                                                    replyQuestions
                                                                        .text,
                                                                uid: Firebase
                                                                    .shared
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid,
                                                                doc: question[
                                                                        index]
                                                                    .id);
                                                            setState(() {
                                                              replyQuestions
                                                                  .text = "";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 99,
                                                            height: 52,
                                                            color: CommonColor
                                                                .buttonColor,
                                                            child: Center(
                                                              child: textWidget(
                                                                text: "ارسال",
                                                                color: CommonColor
                                                                    .checkedDarkColor,
                                                                fontFamily:
                                                                    AppDetails
                                                                        .cairoRegular,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ));
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget Education(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.Educationback,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  setState(() {
                                    page = UserHome.home;
                                  });
                                },
                                color: CommonColor.borderColor,
                              ),
                              padding: const EdgeInsets.only(top: 5),
                            )),
                        textWidget(
                          text: "موضوعات عن النباتات",
                          color: CommonColor.checkedDarkColor,
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 27,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: List.generate(education.length, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              join = education[index].id;
                              join_Hibe = education[index].Title;
                              page = UserHome.educationInkWell;
                            });
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(
                                education[index].logo,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 70),
                                  width: 156,
                                  height: 34,
                                  color: CommonColor.whiteColor,
                                  child: Center(
                                    child: textWidget(
                                      text: education[index].Title,
                                      color: CommonColor.checkedDarkColor,
                                      fontFamily: AppDetails.cairoRegular,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                    ))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget EducationInkWell(BuildContext context) {
    List<EducationTap> educationWHIB = [];
    for (var hebi in educationTap) {
      if (hebi.uid == join) {
        educationWHIB.add(hebi);
      }
    }
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.Educationback,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        textWidget(
                          text: join_Hibe,
                          color: CommonColor.checkedDarkColor,
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 27,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    page = UserHome.Educationback;
                                  });
                                },
                                child: Icon(
                                  CupertinoIcons.right_chevron,
                                  color: CommonColor.calendarColor,
                                )),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 30),
                        shrinkWrap: true,
                        itemCount: educationWHIB.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                join = educationWHIB[index].id;
                                join_Hibe = educationWHIB[index].Title;
                                page = UserHome.educationInkDrs;
                              });
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                width: 344,
                                height: 122,
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
                                  color: "#ffffff".toHexa(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            educationWHIB[index].Title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.asset(educationWHIB[index].logo),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget educationInkDrs(BuildContext context) {
    List<EducationDrs> educationHebi = [];
    for (var hebi in educationHo) {
      if (hebi.uid == join) {
        educationHebi.add(hebi);
      }
    }
    return SingleChildScrollView(
      child: Center(
        child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.Hebi,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 130),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          textWidget(
                            text: join_Hibe,
                            color: CommonColor.checkedDarkColor,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      page = UserHome.Educationback;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.right_chevron,
                                    color: CommonColor.calendarColor,
                                  )),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 30),
                        shrinkWrap: true,
                        itemCount: educationHebi.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      educationHebi[index].Title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CommonColor.fillColor,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          educationHebi[index].logo.first,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          educationHebi[index].logo.last,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  selectImgDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('صورة من كاميرا'),
                  onTap: () => upload(context, type: ImageSource.camera)),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('صورة من المعرض'),
                onTap: () => upload(context, type: ImageSource.gallery),
              ),
            ],
          );
        });
  }

  upload(context, {required ImageSource type}) async {
    PickedFile? image = await ImagePicker.platform.pickImage(source: type);
    if (image != null) {
      setState(() {
        _imagePerson = File(image.path);
      });
      imagePerson = (await Firebase.shared
          .uploadPhoto(folderName: email, img: uid, file: _imagePerson!))!;
      scaffoldKey.showTosta(context,
          message: ' تم تحديد ملف صورة', isError: false);
    } else {
      scaffoldKey.showTosta(context, message: 'يرجى تحديد صورة', isError: true);
    }
    Navigator.of(context).pop();
  }

  getData() async {
    List<HeatModel> heat = await Firebase.shared.heats();
    downMenuItem = heat
        .map((item) => DropdownMenuItem(
            value: item.id.toString(),
            child: textWidget(
              fontFamily: AppDetails.cairoRegular,
              fontSize: 18,
              color: Colors.grey,
              text: item.heat,
            )))
        .toList();
  }

  getPlant() async {
    List<PlantModel> plant = await Firebase.shared.Plants();
    downMenuItem1 = plant
        .map((item) => DropdownMenuItem(
            value: item.id.toString(),
            child: textWidget(
              fontFamily: AppDetails.cairoRegular,
              fontSize: 18,
              color: Colors.grey,
              text: item.plant,
            )))
        .toList();
  }

  report(context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            Expanded(
                child: FutureBuilder<List<ReportsModel>>(
                    future: Firebase.shared.reportsByUser(),
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
                                    page = UserHome.online;
                                    reports = items[index];
                                  });
                                } else {
                                  setState(() {
                                    page = UserHome.outside;
                                    reports = items[index];
                                  });
                                }
                              },
                              child: Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 4,
                                  surfaceTintColor: "#f6f6f6".toHexa(),
                                  color: "#f6f6f6".toHexa(),
                                  shape: RoundedRectangleBorder(
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
                                            Text(
                                              "الجلسة ",
                                              style: TextStyle(
                                                  color: "#787878".toHexa()),
                                            ),
                                            Text(
                                              items[index].id!,
                                              style: TextStyle(
                                                  color: "#9DBA89".toHexa()),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "تاريخ الجلسة:  ",
                                              style: TextStyle(
                                                  color: "#787878".toHexa()),
                                            ),
                                            Text(
                                              DateFormat('d MMM yyyy').format(
                                                  items[index].createdDate),
                                              style: TextStyle(
                                                  color: "#9DBA89".toHexa()),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "عنوان الجلسة: ",
                                              style: TextStyle(
                                                  color: "#787878".toHexa()),
                                            ),
                                            Text(
                                              items[index].title!,
                                              style: TextStyle(
                                                  color: "#9DBA89".toHexa()),
                                            )
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
                  page = UserHome.home;
                });
              },
              child: Container(
                width: 161,
                height: 36,
                decoration: BoxDecoration(
                  boxShadow: [
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
                    'العودة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: "#ffffff".toHexa(),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            )
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
                          page = UserHome.reports;
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
                          page = UserHome.reports;
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

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;

  GradientBorderPainter({required this.gradient, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()..addOval(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:image_picker/image_picker.dart';
import '../../enum/Camera.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';
import '../../Api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  CameraDescription? camera;
  XFile? imagePath;
  CameraType page = CameraType.waiting;

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> selectedImages = <XFile>[];
  String result = "";


  Future<void> selectImagesFromGallery(BuildContext context, {List<XFile>? selectedFiles}) async {
    imagePath = await _imagePicker.pickImage(source: ImageSource.gallery);
    selectedFiles ??= [];
    if (imagePath != null) {
      selectedFiles.add(imagePath!);
      setState(() {
        page = CameraType.example;
      });
      checkImageData(context);
    }
  }

  Future checkImageData(BuildContext context) async {
    http.Response response = await Api.checkImageType(imageData: imagePath);
    var data = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("response body ${response.body}");
      debugPrint("response body params $data");
      debugPrint("response status code ${response.statusCode}");

      setState(() {
        result = convert.jsonEncode(data["prediction"]);
      });

      if (result == '"Healthy"') {
      //صحي
        setState(() {
          result = 'نبتتك تتمتع بصحه جيدة';
        });
      } else if (result == '"Powdery"') {
        setState(() {
          result = 'مرض البياض';
        });
      } else if (result == '"Rust"') {
        setState(() {
          result = 'مرض فطر الصدا';
        });
      // الصدأ
      } else if (result == '"Unrecognized"') {
        setState(() {
          result = 'لم يتم التعرف على المرض';
        });
      }
      //   showToaster(msg: data["prediction"]);
      return response;
    } else if (response.statusCode == 404) {
      debugPrint("response status code ${response.statusCode}");
    } else if (response.statusCode == 500) {
      debugPrint("response status code ${response.statusCode}");
    } else if (response.statusCode == 401) {
      debugPrint("response status code ${response.statusCode}");
    } else {
      debugPrint("something wrong ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  void initState() {
    cameraInit();
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 10), () async {
      setState(() {
        page = CameraType.camera;
      });
    });
    Future.delayed(const Duration(seconds: 20), () async {
      try {
        if (imagePath == null) {
          final image = await _controller!.takePicture();
          if (!context.mounted) return;
          print("object test");
          setState(() {
            imagePath = image;
            page = CameraType.example;
          });
          checkImageData(context);
        }
      } catch (e) {
        // If an error occurs, log the error to the console.
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  cameraInit() async {
    final cameras = await availableCameras();
    camera = cameras.first;
    _controller = CameraController(
      camera!,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == CameraType.camera) {
      return pic(context);
    } else if (page == CameraType.info) {
      return info(context);
    } else if (page == CameraType.example) {
      return example(context);
    } else if (page == CameraType.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget info(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.camera1,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 100),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child: textWidget(
                        text: result,
                        color: CommonColor.fillColor,
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 20,
                      ),
                    ),
                    Visibility(
                      visible: result =='مرض البياض',
                      child: textWidget(
                        text: result,
                        color: CommonColor.fillColor,
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 20,
                      ),
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child: textWidget(
                      text: 'ما هو و ما الطرق التي يجب عليك اتباعها للعلاج :',
                      color: CommonColor.blackColor,
                      fontFamily: AppDetails.cairoRegular,
                      fontSize: 20,
                    ),
                    ),
                    Visibility(
                      visible: result =='مرض البياض',
                      child: textWidget(
                        text: 'ما هو و ما الطرق التي يجب عليك اتباعها للعلاج :',
                        color: CommonColor.blackColor,
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 20,
                      ),
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        ' مرض فطر الصدأ هو مرض فطري يصيب النباتات، ويتسبب في ظهور بقع صدئية على الأوراق والسيقان والثمار والزهور. هذا المرض يسبب ضعفًا في النبات وتدهور في الحالة العامة للنبات المصاب.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        ' إزالة الأوراق المصابة وخصوصاً في بداية ظهور المرض ولا ينبغي ترك المشكلة حتي استفحالها.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child:   Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        '  استعمل رشاش مائي مندفع حتي يقوم بغسل النبات دون كسر الفروع او تقطيع الأوراق و الماء يكون فاتراً.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        'الأسطح الشمعية مفيده في هذه الحالات بحيث تكون كمصائد للحشرات الطائرة والزاحفة, مع وضع ألوان تكون جاذبة كالأصفر ويتم وضعه على اسطح كرتون مقوى أو اسطح خشبية خفيفة ويتم فرد المادة اللاصقة مثل الفازلين او التي المادة التي تستخدم للفئران , ثم توضع قريبة من النبات.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: result =='مرض فطر الصدا',
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        'يمكن رش مواد طبيعية ذات روائح نفاذة ك الزنجبيل والثوم , والبصل والفلفل الحار, ومستخلص ورق النبات كالخطمية فهو مقاوم للذبول أو نبات النيم.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: result =='مرض البياض',
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        ' البياض الدقيقي: هو مرض فطري يظهر على أوراق النباتات كمسحوق أبيض، مما يؤدي إلى تدهور صحة النبات وتقليل إنتاجيته.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: result =='مرض البياض',
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        ' لعلاج هذا المرض، يمكن استخدام مبيدات الفطريات المخصصة للبياض الدقيقي، مع توفير تهوية جيدة حول النبات وتجنب الرطوبة الزائدة.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: "#9DBA89".toHexa(),
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),const SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget pic(context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CameraPreview(_controller!)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 50, left: 10),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: InkWell(
                            onTap: () {
                              selectImagesFromGallery(context);
                            },
                            child: Icon(
                              Icons.upload,
                              color: CommonColor.calendarColor,
                            ),
                          )),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        margin: const EdgeInsets.only(top: 450),
                        height: 80,
                        width: 292,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(15)),
                        child: textWidget(
                          textAlign:TextAlign.center,
                          text: result,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 560, right: 80),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () {
                            if (result == 'مرض فطر الصدا'){
                              setState(() {
                                page = CameraType.info;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: CommonColor.calendarColor,
                          ),
                        )),
                  ],
                )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget example(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.file(
                File(imagePath!.path),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(top: 450),
                  height: 80,
                  width: 292,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(15)),
                  child: textWidget(
                    textAlign:TextAlign.center,
                    text: result,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 560, right: 80),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: InkWell(
                    onTap: () {
                      if (result == 'مرض فطر الصدا'){
                        setState(() {
                          page = CameraType.info;
                        });
                      }
                      if (result == 'مرض البياض'){
                        setState(() {
                          page = CameraType.info;
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: CommonColor.calendarColor,
                    ),
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 50, left: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          page = CameraType.camera;
                        });
                      },
                      child: Icon(
                        Icons.camera,
                        color: CommonColor.calendarColor,
                      ),
                    )),
              )
            ],
          )),
    );
  }
}

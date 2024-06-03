import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/enum/report.dart';
import 'package:ghiras/user_profile.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:ghiras/widgets/showalertdialog.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'Model/AvailableModel.dart';
import 'Model/CallModel.dart';
import 'Model/CaringModel.dart';
import 'Model/HeatModel.dart';
import 'Model/PlantModel.dart';
import 'Model/QuestionsModel.dart';
import 'Model/ReportsModel.dart';
import 'Model/ReviewsModel.dart';
import 'Model/SupportModel.dart';
import 'Model/TimesModel.dart';
import 'Model/UserModel.dart';
import 'enum/Supporttype.dart';
import 'enum/Usertype.dart';
import 'enum/status.dart';

class Firebase {
  static final Firebase shared = Firebase();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection('User');
  final supportRef = FirebaseFirestore.instance.collection('Support');
  final reportsRef = FirebaseFirestore.instance.collection('Reports');
  final availableRef = FirebaseFirestore.instance.collection('Available');
  final reviewsRef = FirebaseFirestore.instance.collection('Reviews');
  final plantRef = FirebaseFirestore.instance.collection('Plant');
  final sessionCallRef = FirebaseFirestore.instance.collection('SessionCall');
  final timesRef = FirebaseFirestore.instance.collection('Times');
  final heatRef = FirebaseFirestore.instance.collection('Heat');
  final caringRef = FirebaseFirestore.instance.collection('Caring');
  final questionsRef = FirebaseFirestore.instance.collection('Questions');

  createAccountUser(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String name,
    required String last,
    required String email,
    required String address,
    required String city,
    required String phone,
    required String password,
    required String experience,
    required String certificate,
    required String years,
    required String cv,
    required Usertype userType,
    required Status status,
  }) async {
    var userId = await createAccountInFirebase(context,
        scaffoldKey: scaffoldKey, email: email, password: password);

    List<UserModel> users = await user();

    if (userId != null) {
      userRef.doc(userId).set({
        "id": "${users.length}${Random().nextInt(999)}",
        'name': name,
        'last': last,
        'uid': userId,
        'image': '',
        'section': '',
        'email': email,
        'address': address,
        'city': city,
        'phone': phone,
        'password': password,
        'experience': experience,
        'certificate': certificate,
        'years': years,
        'cv': cv,
        'status': status.index,
        'type': userType.index,
      }).then((value) async {
        if (userType == Usertype.specialist) {
          showAlertDialog(context,
              title: "تم تسجيل حسابك",
              message: 'سيتم اشعارك عبر البريد الالكتروني بقبول او رفض الحساب ',
              showBtnOne: false, actionBtnTwo: () {
            Navigator.of(context).pop();
          });
        } else {
          login(context,
              scaffoldKey: scaffoldKey, email: email, password: password);
        }
      }).catchError((err) {
        scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
      });
    }
  }

  createAccountInFirebase(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        scaffoldKey.showTosta(context,
            message: 'البريد الإلكتروني مستخدم بالفعل', isError: true);
      }
      return null;
    } catch (e) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
      return null;
    }
  }

  login(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await userByUid(uid: auth.currentUser!.uid).then((UserModel user) {
        switch (user.accountStatus) {
          case Status.active:
            UserProfile.shared.setUser(user: user);
            Navigator.of(scaffoldKey.currentContext!).pushNamedAndRemoveUntil(
                '/HomePage', (Route<dynamic> route) => false,
                arguments: user.userType);
            break;
          case Status.pending:
            scaffoldKey.showTosta(context,
                message: 'الحساب قيد المراجعة', isError: true);
            auth.signOut();
            break;
          case Status.cancel:
            scaffoldKey.showTosta(context,
                message: 'الحساب مغلق', isError: true);
            auth.signOut();
            break;
          case Status.close:
            scaffoldKey.showTosta(context,
                message: 'الحساب مغلق', isError: true);
            auth.signOut();
          // TODO: Handle this case.
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffoldKey.showTosta(context,
            message: "لم يتم العثور على المستخدم", isError: true);
      } else if (e.code == 'wrong-password') {
        scaffoldKey.showTosta(context,
            message: 'كلمة مرور خاطئة', isError: true);
      } else if (e.code == 'too-many-requests') {
        scaffoldKey.showTosta(context,
            message: 'الحساب مغلق مؤقتا', isError: true);
      } else {
        scaffoldKey.showTosta(context, message: e.code, isError: true);
      }
    }
    return;
  }

  createAccount(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String name,
    required String last,
    required String email,
    required String address,
    required String city,
    required String phone,
    required String password,
    required String experience,
    required String certificate,
    required String years,
    required String cv,
    required Usertype userType,
    required Status status,
  }) async {
    var userId = await createAccountInFirebase(context,
        scaffoldKey: scaffoldKey, email: email, password: password);
    List<UserModel> users = await user();
    if (userId != null) {
      userRef.doc(userId).set({
        "id": "#${users.length}${Random().nextInt(999)}",
        'name': name,
        'last': last,
        'uid': userId,
        'image': '',
        'section': '',
        'email': email,
        'address': address,
        'city': city,
        'phone': phone,
        'password': password,
        'experience': experience,
        'certificate': certificate,
        'years': years,
        'cv': cv,
        'status': status.index,
        'type': userType.index,
      }).then((value) async {
        showAlertDialog(context,
            title: "تم تسجيل الحساب",
            message: 'يرجي اشعار المستخدم بتسجيل الحساب ',
            showBtnOne: false, actionBtnTwo: () {
          Navigator.of(context).pop();
        });
        await FirebaseAuth.instance.signOut();
        UserModel? user = await UserProfile.shared.getUser();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: user!.email, password: user.password);
      }).catchError((err) {
        scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
      });
    }
  }

  updateAccountUser(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String name,
    required String last,
    required String email,
    required String address,
    required String city,
    required String phone,
    required String password,
    required String experience,
    required String certificate,
    required String years,
    required String section,
    required String image,
    required String cv,
    required String userId,
    required Usertype userType,
    required Status status,
  }) async {
    userRef.doc(userId).update({
      'name': name,
      'last': last,
      'uid': userId,
      'image': image,
      'section': section,
      'email': email,
      'address': address,
      'city': city,
      'phone': phone,
      'password': password,
      'experience': experience,
      'certificate': certificate,
      'years': years,
      'cv': cv,
      'status': status.index,
      'type': userType.index,
    }).then((value) async {
        scaffoldKey.showTosta(context,
            message: 'تم تعديل الحساب', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }


  deleteAccountUser(
      context, {
        required GlobalKey<ScaffoldState> scaffoldKey,
        required String name,
        required String last,
        required String email,
        required String address,
        required String city,
        required String phone,
        required String password,
        required String experience,
        required String certificate,
        required String years,
        required String section,
        required String image,
        required String cv,
        required String userId,
        required Usertype userType,
        required Status status,
      }) async {
    userRef.doc(userId).update({
      'name': name,
      'last': last,
      'uid': userId,
      'image': image,
      'section': section,
      'email': email,
      'address': address,
      'city': city,
      'phone': phone,
      'password': password,
      'experience': experience,
      'certificate': certificate,
      'years': years,
      'cv': cv,
      'status': status.index,
      'type': userType.index,
    }).then((value) async {
      scaffoldKey.showTosta(context, message: 'تم حذف الحساب', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }


  forgotPassword(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffoldKey.showTosta(context,
            message: "لم يتم العثور على المستخدم", isError: true);
        return false;
      }
    }
  }

  changePassword(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String newPassword,
    required String confirmPassword,
  }) async {
    auth.currentUser!.updatePassword(newPassword).then((value) {
      Navigator.of(scaffoldKey.currentContext!).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context,
          message: "Something went wrong", isError: true);
    });
  }

  signOut(context) async {
    try {
      UserProfile.shared.setUser(user: null);
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, "/LoginPage", (route) => false);
    } catch (_) {}
  }

  Future<List<UserModel>> users(
      {required Status status, required Usertype type}) async {
    final snapshot = await userRef
        .where('status', isEqualTo: status.index)
        .where('type', isEqualTo: type.index)
        .get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<List<UserModel>> restUsers({required String email}) async {
    final snapshot = await userRef.where('email', isEqualTo: email).get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<List<UserModel>> user() async {
    final snapshot = await userRef.get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<UserModel> userByUid({required String uid}) async {
    UserModel userTemp;
    var user = await userRef.doc(uid).get();
    userTemp = UserModel.fromJson(user.data());
    return userTemp;
  }

  Future<String?> upload(
      {required String folderName,
      required String pdfName,
      required XFile? file}) async {
    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {'picked-file-path': file!.path});
    if (kIsWeb && TargetPlatform.macOS == TargetPlatform.macOS) {
      uploadTask = ref
          .child(folderName)
          .child('/${Random().nextInt(999)}$pdfName')
          .putData(await file.readAsBytes(), metadata);
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } else {
      uploadTask = ref
          .child(folderName)
          .child('/${Random().nextInt(999)}$pdfName')
          .putFile(File(file.path), metadata);
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    }
  }

  Future<String?> uploadPhoto(
      {required String folderName,
      required String img,
      required File? file}) async {
    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file!.path});
    if (kIsWeb && TargetPlatform.macOS == TargetPlatform.macOS) {
      uploadTask = ref
          .child(folderName)
          .child('/${Random().nextInt(999)}$img')
          .putData(await file.readAsBytes(), metadata);
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } else {
      uploadTask = ref
          .child(folderName)
          .child('/${Random().nextInt(999)}$img')
          .putFile(File(file.path), metadata);
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    }
  }

  // todo :- Support
  support(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required SupportType type,
    required String title,
    required String subtitle,
  }) {
    supportRef.add({
      'title': title,
      'subtitle': subtitle,
      'type': type.index,
    }).then((value) async {
      Navigator.of(context).pop();
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }
  Future<List<SupportModel>> supportByType({required SupportType type}) async {
    final snapshot =
        await supportRef.where('type', isEqualTo: type.index).get();
    return snapshot.docs
        .map((doc) => SupportModel.fromJson(doc.data()))
        .toList();
  }

// todo :- Reports

  createReports(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required DateTime date,
      required String phone,
      required String place,
      required String title,
      required String uidUser,
      required String nameUser,
      required String idUser,
      required String uidSpecialist,
      required String idSpecialist,
      required String note,
      required String rejected,
      required Status status,
      required Report report}) {
    String id = '#${reportsRef.doc().id.length}${Random().nextInt(999)}';
    reportsRef.doc(id).set({
      'CreatedDate': date,
      'Report': report.index,
      'status': status.index,
      'Rejected': rejected,
      'phone': phone,
      'place': place,
      "id": id,
      'title': title,
      'note': note,
      'uidUser': uidUser,
      'nameUser': nameUser,
      'idUser': idUser,
      'uidSpecialist': uidSpecialist,
      'idSpecialist': idSpecialist,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  updateReports(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required DateTime date,
      required String phone,
      required String place,
      required String title,
      required String uidUser,
      required String nameUser,
      required String idUser,
      required String uidSpecialist,
      required String idSpecialist,
      required String note,
      required String id,
      required String rejected,
      required Status status,
      required Report report}) {
    reportsRef.doc(id).update({
      'CreatedDate': date,
      'Report': report.index,
      'status': status.index,
      'Rejected': rejected,
      'phone': phone,
      'place': place,
      "id": id,
      'title': title,
      'note': note,
      'uidUser': uidUser,
      'nameUser': nameUser,
      'idUser': idUser,
      'uidSpecialist': uidSpecialist,
      'idSpecialist': idSpecialist,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم التحديث بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  updateReportsStatus({required String id, required Status status}) {
    reportsRef.doc(id).update({
      'status': status.index,
    });
  }
  Future<ReportsModel> report({required String uid}) async {
    ReportsModel userTemp;
    var user = await reportsRef.doc(uid).get();
    userTemp = ReportsModel.fromJson(user.data());
    return userTemp;
  }
  Future<List<ReportsModel>> userReports(
      {required String uid, required Status status}) async {
    final snapshot = await reportsRef
        .where('uidUser', isEqualTo: uid)
        .where('status', isEqualTo: status.index)
        .get();
    return snapshot.docs
        .map((doc) => ReportsModel.fromJson(doc.data()))
        .toList();
  }
  Future<List<ReportsModel>> reports({required String uid}) async {
    final snapshot =
        await reportsRef.where('uidSpecialist', isEqualTo: uid).get();
    return snapshot.docs
        .map((doc) => ReportsModel.fromJson(doc.data()))
        .toList();
  }
  Stream<List<ReportsModel>> reportsStream({required String uid}) {
    return reportsRef
        .where('uidSpecialist', isEqualTo: uid)
        .snapshots()
        .map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return ReportsModel.fromJson(doc.data());
      }).toList();
    });
  }
  Future<List<ReportsModel>> reportsBy({required String uid}) async {
    final snapshot = await reportsRef
        .where('uidSpecialist',
            isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .where('uidUser', isEqualTo: uid)
        .get();
    return snapshot.docs
        .map((doc) => ReportsModel.fromJson(doc.data()))
        .toList();
  }
  Future<List<ReportsModel>> reportsByUser() async {
    final snapshot = await reportsRef
        .where('uidUser', isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .get();
    return snapshot.docs
        .map((doc) => ReportsModel.fromJson(doc.data()))
        .toList();
  }
// todo :- Available

  createTime(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required DateTime Date,
      required String uid}) {
    String userId = availableRef.doc().id;
    availableRef.doc(userId).set({
      'id': userId,
      'uid': uid,
      'Date': Date,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  deleteTime(context,
      {required GlobalKey<ScaffoldState> scaffoldKey, required String uid}) {
    availableRef.doc(uid).delete().then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  Future<List<AvailableModel>> available({required String uid}) async {
    final snapshot = await availableRef.where('uid', isEqualTo: uid).get();
    return snapshot.docs
        .map((doc) => AvailableModel.fromJson(doc.data()))
        .toList();
  }

  Stream<List<AvailableModel>> availableStream({required String uid}) {
    return availableRef
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return AvailableModel.fromJson(doc.data());
      }).toList();
    });
  }

// todo :- Reviews
  createReviews(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String logo,
      required String name,
      required String note,
      required String uid,
      required String id,
      required String uidSpecialist,
      required double review}) {
    reviewsRef.doc(id).set({
      'logo': logo,
      'name': name,
      'note': note,
      'uid': uid,
      'id': id,
      'uidSpecialist': uidSpecialist,
      "review": review,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  Future<List<ReviewsModel>> reviews({required String uid}) async {
    final snapshot =
        await reviewsRef.where('uidSpecialist', isEqualTo: uid).get();
    return snapshot.docs
        .map((doc) => ReviewsModel.fromJson(doc.data()))
        .toList();
  }
  Future<ReviewsModel> reviewsByUid({required String uid}) async {
    ReviewsModel userTemp;
    var user = await reviewsRef.doc(uid).get();
    userTemp = ReviewsModel.fromJson(user.data());
    return userTemp;
  }

// todo :- heat
  createHeat(context,
      {required GlobalKey<ScaffoldState> scaffoldKey, required String heat}) {
    String id = heatRef.doc().id;
    heatRef.doc(id).set({
      'id': id,
      'Heat': heat,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }
  Future<List<HeatModel>> heats() async {
    final snapshot = await heatRef.get();
    return snapshot.docs.map((doc) => HeatModel.fromJson(doc.data())).toList();
  }
  Future<HeatModel> heat({required String uid}) async {
    HeatModel temp;
    var plant = await heatRef.doc(uid).get();
    temp = HeatModel.fromJson(plant.data());
    return temp;
  }

// todo :- plant
  createPlant(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String plant,
    required String note,
    required String logo,
    required String uid,
    required String heat,
    required bool toxic,
  }) {
    String id = '#${Random().nextInt(999)}';
    plantRef.doc(id).set({
      'id': id,
      'logo': logo,
      'plant': plant,
      'note': note,
      'Toxic': toxic,
      'Heat': heat,
      'uid': uid,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  updatePlant(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String plant,
    required String note,
    required String logo,
    required String uid,
    required String heat,
    required String id,
    required bool toxic,
  }) {
    plantRef.doc(id).update({
      'id': id,
      'logo': logo,
      'plant': plant,
      'note': note,
      'Toxic': toxic,
      'Heat': heat,
      'uid': uid,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  deletePlant(context,
      {required GlobalKey<ScaffoldState> scaffoldKey, required String uid}) {
    plantRef.doc(uid).delete().then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الحـذف بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  Future<PlantModel> plant({required String uid}) async {
    PlantModel temp;
    var plant = await plantRef.doc(uid).get();
    temp = PlantModel.fromJson(plant.data());
    return temp;
  }
  Stream<List<PlantModel>> plants() {
    return plantRef
        .where('uid', isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .snapshots()
        .map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return PlantModel.fromJson(doc.data());
      }).toList();
    });
  }
  Future<List<PlantModel>> Plants() async {
    final snapshot = await plantRef
        .where('uid', isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .get();
    return snapshot.docs.map((doc) => PlantModel.fromJson(doc.data())).toList();
  }

// todo :- times

  createTimes(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String plant,
      required String note,
      required String uid,
      required DateTime date}) {
    String id = '#${Random().nextInt(999)}';
    timesRef.doc(id).set({
      'id': id,
      'plant': plant,
      'note': note,
      'uid': uid,
      "Date": date,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  updateTimes(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String plant,
      required String note,
      required String uid,
      required String id,
      required DateTime date}) {
    timesRef.doc(id).set({
      'id': id,
      'plant': plant,
      'note': note,
      'uid': uid,
      "Date": date,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  deleteTimes(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String id,
  }) {
    timesRef.doc(id).delete().then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  Future<List<TimesModel>> times_SnackBar() async {
    final snapshot =
    await timesRef.where('uid', isEqualTo: Firebase.shared.auth.currentUser!.uid).get();
    return snapshot.docs.map((doc) => TimesModel.fromJson(doc.data())).toList();
  }

  Stream<List<TimesModel>> times() {
    return timesRef.where('uid', isEqualTo: Firebase.shared.auth.currentUser!.uid).snapshots()
        .map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return TimesModel.fromJson(doc.data());
      }).toList();
    });
  }

// todo :- sessionCall
  Stream<List<SessionCallModel>> Call() {
    return sessionCallRef
        .where('uidUser', isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .where('Status', isEqualTo: false)
        .snapshots()
        .map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return SessionCallModel.fromJson(doc.data());
      }).toList();
    });
  }

// todo :- caring

  createCaring(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String plants,
    required String Duration,
    required String note,
    required String number,
    required String uid,
  }) {
    String id = '#${Random().nextInt(999)}';
    caringRef.doc(id).set({
      'id': id,
      'plants': plants,
      'note': note,
      'uid': uid,
      'number': number,
      "Duration": Duration,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }
  Future<List<CaringModel>> caring() async {
    final snapshot = await caringRef.get();
    return snapshot.docs
        .map((doc) => CaringModel.fromJson(doc.data()))
        .toList();
  }

// todo :- questions

  createQuestions(
    context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String questions,
    required String uid,
  }) {
    String id = '#${Random().nextInt(999)}';
    questionsRef.doc(id).set({
      'id': id,
      'questions': questions,
      'uid': uid,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
      Navigator.of(context).pop();
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }

  Future<List<QuestionsModel>> question() async {
    final snapshot = await questionsRef.get();
    return snapshot.docs
        .map((doc) => QuestionsModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<QuestionsModel>> questionByUid() async {
    final snapshot = await questionsRef
        .where('uid', isEqualTo: Firebase.shared.auth.currentUser!.uid)
        .get();
    return snapshot.docs
        .map((doc) => QuestionsModel.fromJson(doc.data()))
        .toList();
  }

  // todo :- questions

  replyQuestions(context,
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String questions,
      required String uid,
      required String doc}) {
    String id = '#${Random().nextInt(999)}';
    questionsRef.doc(doc).collection('replyQuestions').doc(id).set({
      'id': id,
      'questions': questions,
      'uid': uid,
    }).then((value) async {
      scaffoldKey.showTosta(context,
          message: 'تم الإضافة بنجاح', isError: false);
    }).catchError((err) {
      scaffoldKey.showTosta(context, message: 'هناك خطأ ما', isError: true);
    });
  }
  Future<List<QuestionsModel>> replyQuestionsGet({required String doc}) async {
    final snapshot =
        await questionsRef.doc(doc).collection('replyQuestions').get();
    return snapshot.docs
        .map((doc) => QuestionsModel.fromJson(doc.data()))
        .toList();
  }
}

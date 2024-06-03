import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../Firebase.dart';
import '../Model/SupportModel.dart';
import '../Model/UserModel.dart';
import '../enum/Supporttype.dart';
import '../user_profile.dart';
import '../widgets/assets.dart';
import '../widgets/commonColor.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {


  void initState() {
    // TODO: implement initState
    super.initState();
    join();
  }

  bool Hebi = false;

  join() async {
    UserModel? hebi = await UserProfile.shared.getUser();
    if (hebi != null) {
      setState(() {
        Hebi = true;
      });
    } else {
      setState(() {
        Hebi = false;
      });
    }
  }

  String visible = '';

  bool isSelected(String selected) => visible == selected;

  void toggleSelected(String selected) {
    if (!isSelected(selected)) {
      setState(() {
        visible = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 216,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          scale: 1.0,
                          opacity: 1.0,
                          image: AssetImage(
                            Assets.shared.support,
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  Container(
                    width: 334,
                    height: 80,
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
                        borderRadius: BorderRadius.circular(35)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
//                            Image.asset(
//                               Assets.shared.vector,
//                               height: 21.88,
//                               width: 25,
//                             ),
                            const Text(
                              "ارشادات الاستخدام ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ],
                        ),
                        Text(
                          "كيف نقدر نخدمك ؟",
                          style: TextStyle(
                              color: "#CFE5A5".toHexa(), fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder<List<SupportModel>>(
                  future:
                      Firebase.shared.supportByType(type: SupportType.account),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SupportModel> support = snapshot.data!;
                      return Wrap(
                          children: List.generate(support.length, (index) {
                        return Container(
                            constraints: const BoxConstraints(
                              maxWidth: 350,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    0.0,
                                    3.0,
                                  ),
                                  blurRadius: 0.20,
                                  spreadRadius: 0.20,
                                ),
                              ],
                              color: Colors.white,
                              border: Border.all(
                                color: "#9DBA89".toHexa(),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            support[index].title!,
                                            style: TextStyle(
                                                color: "#9DBA89".toHexa(),
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RawChip(
                                      backgroundColor: CommonColor.whiteColor,
                                      selectedColor: CommonColor.whiteColor,
                                      shape: ContinuousRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white, width: 0),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      elevation: 0,
                                      label: isSelected(
                                              support[index].subtitle!)
                                          ? const Icon(Icons.arrow_upward)
                                          : const Icon(Icons.arrow_downward),
                                      selected:
                                          isSelected(support[index].subtitle!),
                                      showCheckmark: false,
                                      pressElevation: 0,
                                      onSelected: (bool value) {
                                        if (isSelected(support[index].subtitle!) == true){
                                          toggleSelected('');
                                        } else {
                                          toggleSelected(support[index].subtitle!);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Visibility(
                                    visible:
                                        isSelected(support[index].subtitle!),
                                    child: const Divider()),
                                Visibility(
                                    visible:
                                        isSelected(support[index].subtitle!),
                                    child: const SizedBox(
                                      height: 5,
                                    )),
                                Visibility(
                                    visible:
                                        isSelected(support[index].subtitle!),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                support[index].subtitle!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ));
                      }));
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 105,
        height: 40,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              0.0,
              5.0,
            ),
            blurRadius: 0.10,
            spreadRadius: 0.10,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: (){
            if(Hebi == true){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }else{
              Navigator.pushNamed(context, '/LoginPage');
            }
          },
          child: Icon(
            Icons.home,
            color: "#D1DFC8".toHexa(),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

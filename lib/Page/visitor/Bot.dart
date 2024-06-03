import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:http/http.dart' as http;
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class Bot extends StatefulWidget {
  const Bot({super.key});

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  List<String> messagesList = [];

  Future<void> sendMessage(String message) async {
    var apiUrl = Uri.parse(
        'http://172.20.10.3:8000/chat?message=${message.toString()}');
    var response = await http.post(
      apiUrl,
      body: json.encode({}),
    );
    debugPrint("apiUrl $apiUrl");
    debugPrint("status ${response.statusCode}");

    if (response.statusCode == 200) {
      var responseData = jsonDecode(utf8.decode(response.bodyBytes));
      var botResponse = responseData['response'];
      debugPrint("response ${response.body}");

      setState(() {
        messagesList.add(botResponse);
      });
    } else {
      if (kDebugMode) {
        print('Error: ${response.reasonPhrase}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(); // Auto-dismiss after 2 seconds
          });
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Image.asset(Assets.shared.chatbot1),
              content: Text(
                "اهلا! انا ليف صديقك الذكي\nحدثني عن نباتاتك الجميلة!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: "#8f8f8f".toHexa(),
                ),
              ),
              actions: [
                Center(
                  child: CircularProgressIndicator(
                    color: "#1aceb9".toHexa(),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Stack(
                children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    Assets.shared.Rectangleboot,
                    width: MediaQuery.of(context).size.width,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(top: 50, right: 40),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image.asset(Assets.shared.start3),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              textWidget(
                                text: "The Leafbot",
                                color: CommonColor.blackColor,
                                fontFamily: AppDetails.cairoRegular,
                                fontSize: 27,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset(Assets.shared.chatbot),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: messagesList.length + 1,
                            // Add 1 for the welcome text
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // Render welcome text at index 0
                                return Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * 0.6),
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: "#EDF3E9".toHexa(),
                                                border: Border.all(
                                                  color: "#EDF3E9".toHexa(),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'مرحبا انا ليف، كيف استطيع مساعدتك؟',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          "#000000".toHexa()),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              CommonColor.whiteColor,
                                          child: Image.asset(
                                            Assets.shared.chatbot,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ]);
                              } else {
                                // Render messages from the API
                                final message = messagesList[index - 1]; // Adjust index for messagesList
                                final isUserMessage = (index - 1) % 2 == 0; // Adjust index for messagesList
                                return Stack(
                                  alignment: isUserMessage ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Align(
                                        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                                        child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.6),
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: "#EDF3E9".toHexa(),
                                              border: Border.all(
                                                color: "#EDF3E9".toHexa(),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                message,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: "#000000".toHexa()),
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                        CommonColor.whiteColor,
                                        child: Image.asset(
                                          isUserMessage ? Assets.shared.woman : Assets.shared.chatbot,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    4.0,
                                    -4.0,
                                  ),
                                  blurRadius: 4.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              )),
                          height: 91,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 220,
                                  child: TextFormField(
                                    onFieldSubmitted: (hebi) {
                                      if (hebi.isNotEmpty) {
                                        setState(() {
                                          messagesList.add(hebi.trim());
                                        });
                                      }
                                      sendMessage(hebi.toString());
                                      _textController.clear();
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'تحدث مع ليف..',
                                    ),
                                    controller: _textController,
                                  )),
                              InkWell(
                                onTap: () {
                                  String message = _textController.text.trim();
                                  if (_textController.text.trim().isNotEmpty) {
                                    setState(() {
                                      messagesList
                                          .add(_textController.text.trim());
                                    });
                                  }
                                  sendMessage(_textController.text.toString());
                                  _textController.clear();
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: CommonColor.botColor,
                                  child: Image.asset(Assets.shared.sendchat),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}

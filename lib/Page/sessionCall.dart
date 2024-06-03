import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ghiras/Model/ReportsModel.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../Firebase.dart';
import '../Model/UserModel.dart';
import '../widgets/AppDetails.dart';
import '../widgets/assets.dart';
import '../widgets/commonColor.dart';
import '../widgets/commonWidget.dart';

class SessionCall extends StatefulWidget {
  final ReportsModel report;

  const SessionCall({super.key, required this.report});

  @override
  State<SessionCall> createState() => _SessionCallState();
}

class _SessionCallState extends State<SessionCall> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRenderers();
    navigator.mediaDevices.ondevicechange = (event) async {
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    localRenderer.dispose();
    remoteRenderer.dispose();
  }

  void initRenderers() async {
    Future.delayed(const Duration(seconds: 1), () {
      initLocalCamera();
    });
    MediaStream tempVideo = await createLocalMediaStream('remoteVideoStream');
    setState(() {
      remoteStream = tempVideo;
    });
    onRemoveRemoteStream = ((stream) {
      remoteRenderer.srcObject = null;
    });
    onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      setState(() {});
    });
    await remoteRenderer.initialize();
    await localRenderer.initialize();
  }

  Function(MediaStream stream)? onLocalStream;
  Function(MediaStream stream)? onAddRemoteStream;
  Function(MediaStream stream)? onRemoveRemoteStream;

  late RTCPeerConnection peerConnection;
  late MediaStream localStream;
  late MediaStream remoteStream;
  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();
  List<MediaDeviceInfo>? _mediaDevicesList;
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };
  Map<String, dynamic> offerSdpConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': []
  };
  bool muted = false;
  bool video = false;

  initLocalCamera() async {
    localStream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});
    _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    localRenderer.srcObject = localStream;
    setState(() {});
    create(remoteRenderer);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
              child: SingleChildScrollView(
                  child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child:
                          OrientationBuilder(builder: (context, orientation) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Stack(children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 1.5,
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
                                    color: "#D1DFC8".toHexa(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: RTCVideoView(remoteRenderer,
                                      mirror: true,
                                      objectFit: RTCVideoViewObjectFit
                                          .RTCVideoViewObjectFitContain),
                                ),
                                InkWell(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20, top: 10),
                                  child: Image.asset(
                                    Assets.shared.size,
                                  ),
                                )),
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
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
                                      color: "#D1DFC8".toHexa(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.width / 1.5,
                                    width: 333,
                                    child: RTCVideoView(
                                      localRenderer,
                                      objectFit: RTCVideoViewObjectFit
                                          .RTCVideoViewObjectFitCover,
                                    ),
                                  ),
                                  Container(
                                    width: 330,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.5),
                                          offset: const Offset(
                                            0.0,
                                            2.0,
                                          ),
                                          blurRadius: 0.10,
                                          spreadRadius: 0.10,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              hangUp();
                                            },
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Image.asset(
                                                  Assets.shared.calldesing,
                                                ),
                                                Image.asset(
                                                  Assets.shared.callend,
                                                ),
                                              ],
                                            )),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    video = !video;
                                                  });
                                                  switchCamera();
                                                },
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Image.asset(
                                                      Assets.shared.calldesing_1,
                                                    ),
                                                    Image.asset(
                                                      video ?Assets.shared.video1: Assets.shared.video,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  muteMic();
                                                  setState(() {
                                                    muted = !muted;
                                                  });
                                                },
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Image.asset(
                                                      Assets
                                                          .shared.calldesing_1,
                                                    ),
                                                    Image.asset(
                                                      muted
                                                          ? Assets.shared.volume
                                                          : Assets.shared.mute,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]);
                      })))),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
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
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color:
                          const Color(0xFF9DBA89), //<---- Insert Gradient Here
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await initLocalCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35)),
                        child: FutureBuilder<UserModel>(
                            future: Firebase.shared
                                .userByUid(uid: widget.report.uidUser!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                UserModel? user = snapshot.data;
                                return textWidget(
                                  text: '${user!.name} ${user.last}',
                                  color: CommonColor.borderColor,
                                  fontSize: 18,
                                  fontFamily: AppDetails.cairoSemiBold,
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(
                                  0xFF9DBA89), //<---- Insert Gradient Here
                            ),
                            borderRadius: BorderRadius.circular(35)),
                        child: textWidget(
                          color: const Color(0xFF365133),
                          fontSize: 16,
                          fontFamily: AppDetails.cairoSemiBold,
                          text: DateFormat('hh:mm a')
                              .format(widget.report!.createdDate),
                        )),
                  ],
                )),
          ),
        ));
  }

  create(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef =
        db.collection('SessionCall').doc(widget.report.id);
    peerConnection =
        await createPeerConnection(configuration, offerSdpConstraints);
    registerPeerConnectionListeners();
    localStream.getTracks().forEach((track) {
      peerConnection.addTrack(track, localStream);
    });
    // Code for collecting ICE candidates below
    var callerCandidatesCollection = roomRef.collection('1');

    peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      callerCandidatesCollection.add(candidate.toMap());
    };
    // Finish Code for collecting ICE candidate

    // Add code for creating a room
    RTCSessionDescription offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);

    Map<String, dynamic> roomWithOffer = {
      'offer': offer.toMap(),
      'uidSpecialist': widget.report.uidSpecialist,
      'uidUser': widget.report.uidUser,
      'id': widget.report.id,
      'Status': false,
    };

    await roomRef.set(roomWithOffer);
    await remoteRenderer.initialize();
    MediaStream tempVideo = await createLocalMediaStream('remoteVideoStream');
    setState(() {
      remoteStream = tempVideo;
    });
    peerConnection.onTrack = (RTCTrackEvent event) {
      event.streams[0].getTracks().forEach((track) {
        remoteStream.addTrack(track);
        remoteRenderer.srcObject = remoteStream;
        if (kIsWeb) {
          remoteRenderer.muted = false;
        }
      });
    };

    roomRef.snapshots().listen((snapshot) async {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection.getRemoteDescription() != null &&
          data['answer'] != null) {
        var answer = RTCSessionDescription(
          data['answer']['sdp'],
          data['answer']['type'],
        );
        await peerConnection.setRemoteDescription(answer);
      }
    });

    roomRef.collection('2').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          peerConnection.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      });
    });
  }

  // ignore: duplicate_ignore
  Future<void> hangUp() async {
    Navigator.of(context).pop();
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef =
        db.collection('SessionCall').doc(widget.report.id);
    roomRef.update({
      'Status': true,
    });
    if (kIsWeb) {
      localStream.getTracks().forEach((track) => track.stop());
    }
    await localStream.dispose();
    localRenderer.srcObject = null;

    if (remoteStream != null) {
      remoteStream.getTracks().forEach((track) => track.stop());
      await remoteStream.dispose();
    }
    if (peerConnection != null) peerConnection.close();
  }

  void registerPeerConnectionListeners() {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      if (kDebugMode) {
        print('ICE gathering state changed: $state');
      }
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) async {
      if (kDebugMode) {
        print('Connection state change: $state');
      }

      if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
        if (kIsWeb) {
          localStream.getTracks().forEach((track) => track.stop());
        }
        await localStream.dispose();
        localRenderer.srcObject = null;

        if (remoteStream != null) {
          remoteStream.getTracks().forEach((track) => track.stop());
          await remoteStream.dispose();
        }
        if (peerConnection != null) peerConnection.close();
        Navigator.pop(context);
      }
    };

    peerConnection.onSignalingState = (RTCSignalingState state) {
      if (kDebugMode) {
        print('Signaling state change: $state');
      }
    };

    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      if (kDebugMode) {
        print('ICE connection state change: $state');
      }
    };

    peerConnection.onAddStream = (MediaStream stream) {
      if (kDebugMode) {
        print("Add remote stream");
      }
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
      setState(() {});
    };
  }

  void muteMic() {
    if (localStream != null) {
      bool enabled = localStream.getAudioTracks()[0].enabled;
      localStream.getAudioTracks()[0].enabled = !enabled;
    }
  }

  void switchCamera() {
    if (localStream != null) {
      bool enabled = localStream.getVideoTracks()[0].enabled;
      localStream.getVideoTracks()[0].enabled = !enabled;
      //   Helper.switchCamera(localStream.getVideoTracks()[0]);
    }
  }
}

class Call extends StatefulWidget {
  final String id;
  final String name;

  const Call({super.key, required this.id, required this.name});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRenderers();
    navigator.mediaDevices.ondevicechange = (event) async {
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    localRenderer.dispose();
    remoteRenderer.dispose();
  }

  void initRenderers() async {
    Future.delayed(const Duration(seconds: 1), () {
      initLocalCamera();
    });
    MediaStream tempVideo = await createLocalMediaStream('remoteVideoStream');
    setState(() {
      remoteStream = tempVideo;
    });
    onRemoveRemoteStream = ((stream) {
      remoteRenderer.srcObject = null;
    });
    onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      setState(() {});
    });
    await remoteRenderer.initialize();
    await localRenderer.initialize();
  }

  Function(MediaStream stream)? onLocalStream;
  Function(MediaStream stream)? onAddRemoteStream;
  Function(MediaStream stream)? onRemoveRemoteStream;

  late RTCPeerConnection peerConnection;
  late MediaStream localStream;
  late MediaStream remoteStream;
  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();
  List<MediaDeviceInfo>? _mediaDevicesList;
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };
  Map<String, dynamic> offerSdpConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': []
  };
  bool muted = false;
  bool video = false;

  initLocalCamera() async {
    localStream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});
    _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    localRenderer.srcObject = localStream;
    setState(() {});
    joinRoom(remoteRenderer);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
              child: SingleChildScrollView(
                  child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child:
                          OrientationBuilder(builder: (context, orientation) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Stack(children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 1.5,
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
                                    color: "#D1DFC8".toHexa(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: RTCVideoView(remoteRenderer,
                                      mirror: true,
                                      objectFit: RTCVideoViewObjectFit
                                          .RTCVideoViewObjectFitContain),
                                ),
                                InkWell(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20, top: 10),
                                  child: Image.asset(
                                    Assets.shared.size,
                                  ),
                                )),
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
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
                                      color: "#D1DFC8".toHexa(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.width / 1.5,
                                    width: 333,
                                    child: RTCVideoView(
                                      localRenderer,
                                      objectFit: RTCVideoViewObjectFit
                                          .RTCVideoViewObjectFitCover,
                                    ),
                                  ),
                                  Container(
                                    width: 330,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.5),
                                          offset: const Offset(
                                            0.0,
                                            2.0,
                                          ),
                                          blurRadius: 0.10,
                                          spreadRadius: 0.10,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              hangUp();
                                            },
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Image.asset(
                                                  Assets.shared.calldesing,
                                                ),
                                                Image.asset(
                                                  Assets.shared.callend,
                                                ),
                                              ],
                                            )),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    video = !video;
                                                  });
                                                  switchCamera();
                                                },
                                                child: Stack(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .center,
                                                  children: [
                                                    Image.asset(
                                                      Assets.shared.calldesing_1,
                                                    ),
                                                    Image.asset(
                                                      video ?Assets.shared.video1: Assets.shared.video,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  muteMic();
                                                  setState(() {
                                                    muted = !muted;
                                                  });
                                                },
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Image.asset(
                                                      Assets
                                                          .shared.calldesing_1,
                                                    ),
                                                    Image.asset(
                                                      muted
                                                          ? Assets.shared.volume
                                                          : Assets.shared.mute,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]);
                      })))),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
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
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color:
                          const Color(0xFF9DBA89), //<---- Insert Gradient Here
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await initLocalCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35)),
                        child: textWidget(
                          text: widget.name,
                          color: CommonColor.borderColor,
                          fontSize: 18,
                          fontFamily: AppDetails.cairoSemiBold,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(
                                  0xFF9DBA89), //<---- Insert Gradient Here
                            ),
                            borderRadius: BorderRadius.circular(35)),
                        child: textWidget(
                          color: const Color(0xFF365133),
                          fontSize: 16,
                          fontFamily: AppDetails.cairoSemiBold,
                          text: DateFormat('hh:mm a').format(DateTime.now()),
                        )),
                  ],
                )),
          ),
        ));
  }

  joinRoom(RTCVideoRenderer remoteVideo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('SessionCall').doc(widget.id);
    var roomSnapshot = await roomRef.get();
    if (kDebugMode) {
      print('Got room ${roomSnapshot.exists}');
    }

    if (roomSnapshot.exists) {
      await roomRef.update({
        'Status': true,
      });
      if (kDebugMode) {
        print('Create PeerConnection with configuration: $configuration');
      }
      peerConnection =
          await createPeerConnection(configuration, offerSdpConstraints);

      registerPeerConnectionListeners();

      localStream.getTracks().forEach((track) {
        peerConnection.addTrack(track, localStream);
      });

      // Code for collecting ICE candidates below
      var calleeCandidatesCollection = roomRef.collection('2');
      peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
        // ignore: unnecessary_null_comparison
        if (candidate == null) {
          if (kDebugMode) {
            print('onIceCandidate: complete!');
          }
          return;
        }
        if (kDebugMode) {
          print('onIceCandidate: ${candidate.toMap()}');
        }
        calleeCandidatesCollection.add(candidate.toMap());
      };
      // Code for collecting ICE candidate above
      await remoteRenderer.initialize();
      MediaStream tempVideo = await createLocalMediaStream('remoteVideoStream');
      setState(() {
        remoteStream = tempVideo;
      });
      peerConnection.onTrack = (RTCTrackEvent event) {
        if (kDebugMode) {
          print('Got remote track: ${event.streams[0]}');
        }
        event.streams[0].getTracks().forEach((track) {
          if (kDebugMode) {
            print('Add a track to the remoteStream: $track');
          }
          remoteStream.addTrack(track);
          remoteRenderer.srcObject = remoteStream;
          if (kIsWeb) {
            remoteRenderer.muted = false;
          }
        });
      };

      // Code for creating SDP answer below
      var data = roomSnapshot.data() as Map<String, dynamic>;
      var offer = data['offer'];
      await peerConnection.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']),
      );
      var answer = await peerConnection.createAnswer();

      await peerConnection.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        'answer': {'type': answer.type, 'sdp': answer.sdp},
      };

      await roomRef.update(roomWithAnswer);
      // Finished creating SDP answer

      // Listening for remote ICE candidates below
      roomRef.collection('1').snapshots().listen((snapshot) {
        snapshot.docChanges.forEach((document) {
          var data = document.doc.data() as Map<String, dynamic>;
          if (kDebugMode) {
            print(data);
          }
          if (kDebugMode) {
            print('Got new remote ICE candidate: $data');
          }
          peerConnection.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        });
      });
    }
  }

  // ignore: duplicate_ignore
  Future<void> hangUp() async {
    Navigator.of(context).pop();
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('SessionCall').doc(widget.id);
    roomRef.update({
      'Status': true,
    });
    if (kIsWeb) {
      localStream.getTracks().forEach((track) => track.stop());
    }
    await localStream.dispose();
    localRenderer.srcObject = null;

    if (remoteStream != null) {
      remoteStream.getTracks().forEach((track) => track.stop());
      await remoteStream.dispose();
    }
    if (peerConnection != null) peerConnection.close();
  }

  void registerPeerConnectionListeners() {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      if (kDebugMode) {
        print('ICE gathering state changed: $state');
      }
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) async {
      if (kDebugMode) {
        print('Connection state change: $state');
      }

      if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
        if (kIsWeb) {
          localStream.getTracks().forEach((track) => track.stop());
        }
        await localStream.dispose();
        localRenderer.srcObject = null;

        if (remoteStream != null) {
          remoteStream.getTracks().forEach((track) => track.stop());
          await remoteStream.dispose();
        }
        if (peerConnection != null) peerConnection.close();
        Navigator.pop(context);
      }
    };

    peerConnection.onSignalingState = (RTCSignalingState state) {
      if (kDebugMode) {
        print('Signaling state change: $state');
      }
    };

    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      if (kDebugMode) {
        print('ICE connection state change: $state');
      }
    };

    peerConnection.onAddStream = (MediaStream stream) {
      if (kDebugMode) {
        print("Add remote stream");
      }
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
      setState(() {});
    };
  }

  void muteMic() {
    if (localStream != null) {
      bool enabled = localStream.getAudioTracks()[0].enabled;
      localStream.getAudioTracks()[0].enabled = !enabled;
    }
  }

  Future<void> switchCamera() async {
    if (localStream != null) {
      bool enabled = localStream.getVideoTracks()[0].enabled;
      localStream.getVideoTracks()[0].enabled = !enabled;
   //   Helper.switchCamera(localStream.getVideoTracks()[0]);
    }
  }
}

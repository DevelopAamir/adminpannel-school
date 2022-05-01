import 'dart:async';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_html/html.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_channel.dart' as RtcChannel;
import 'package:permission_handler/permission_handler.dart';

const appid = "93c6765985654033bf9c6dab27ab09d0";
const token = "eedad02e296c42f0a9bef40bed1bf2a1";

class AgoraSDK extends StatefulWidget {
  final class_;
  final section;
  const AgoraSDK({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<AgoraSDK> createState() => _AgoraSDKState();
}

class _AgoraSDKState extends State<AgoraSDK> {
  List<int?> _remoteUid = [];
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool camera = true;
  bool audio = true;
  var selectedRemoteUser;

  @override
  void initState() {
    super.initState();
    createchannel();
  }

  createchannel() async {
    try {
      final channel =
          await RtcChannel.RtcChannel.create('khhasdyuagdsiuiusgfigff')
              .then((value) {
        //   value.joinChannel(token, null, 0, ChannelMediaOptions());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initAgora() async {
    // retrieve permissions

    window.navigator.getUserMedia(audio: true, video: true).then((v) {
//code to execute after accessing
      log('microphone and camera accessed');
    });

    //create the engine
    try {
      window.navigator.permissions!
          .query({"name": "camera"}).then((value) async {
        if (value.state != "denied") {
          _engine = await RtcEngine.create(appid);

          await _engine.enableVideo();
          _engine.setEventHandler(
            RtcEngineEventHandler(
              joinChannelSuccess: (String channel, int uid, int elapsed) {
                Fluttertoast.showToast(msg: 'Joined Successfully');
                setState(() {
                  _localUserJoined = true;
                });
              },
              userJoined: (int uid, int elapsed) {
                Fluttertoast.showToast(msg: 'User $uid joined');
                setState(() {
                  _remoteUid.add(uid);
                });
              },
              userOffline: (int uid, UserOfflineReason reason) {
                print("remote user $uid left channel");
                setState(() {
                  _remoteUid.remove(uid);
                });
              },
            ),
          );

          await _engine.joinChannel(
              token, widget.class_ + widget.section, null, 0);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  leave() async {
    await _engine.leaveChannel();
    cameraButton();
    audioButton();
    Navigator.pop(context);
  }

  cameraButton() async {
    if (camera == true) {
      await _engine.disableVideo();
      setState(() {
        camera = false;
      });
    } else {
      await _engine.enableVideo();
      setState(() {
        camera = true;
      });
    }
  }

  audioButton() async {
    if (audio == true) {
      await _engine.disableAudio();
      setState(() {
        audio = false;
      });
    } else {
      await _engine.enableAudio();
      setState(() {
        audio = true;
      });
    }
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff020E1F),
      appBar: AppBar(
          backgroundColor: Color(0xff020E1F),
          title: const Text('Agora Video Call'),
          actions: [
            // OutlinedButton(
            //     onPressed: () async {
            //       await leave();
            //     },
            //     child: Text(
            //       'Leave',
            //       style: TextStyle(color: Colors.white),
            //     )),
            // OutlinedButton(
            //     onPressed: () async {
            //       await audioButton();
            //     },
            //     child: Text(
            //       audio ? 'Disable Audio' : 'Enable Audio',
            //       style: TextStyle(color: Colors.white),
            //     )),
            // OutlinedButton(
            //     onPressed: () async {
            //       await cameraButton();
            //     },
            //     child: Text(
            //       camera ? 'Disable Camera' : 'Enable Camera',
            //       style: TextStyle(color: Colors.white),
            //     )),
            // OutlinedButton(
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   Participants(widget: _remoteVideo())));
            //     },
            //     child: Text(
            //       'Participants',
            //       style: TextStyle(color: Colors.white),
            //     )),
          ]),
      endDrawer: Container(
        color: Color(0xff121A37),
        width: 200,
        child: _remoteVideo(),
      ),
      body: Stack(
        children: [
          Center(
            child: selectedRemoteUser == null
                ? Text(
                    'No Selected User Found',
                    style: TextStyle(color: Colors.white),
                  )
                : RtcRemoteView.SurfaceView(
                    uid: selectedRemoteUser,
                    channelId: 'test',
                  ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromARGB(255, 143, 137, 161).withOpacity(0.2),
                    width: 100,
                    height: 150,
                    child: Center(
                      child: _localUserJoined
                          ? RtcLocalView.SurfaceView(
                              channelId: 'test',
                            )
                          : CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromARGB(255, 146, 207, 243),
                              color: Color.fromARGB(255, 54, 55, 104),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: audio ? Icon(Icons.mic) : Icon(Icons.mic_off),
                          color: Colors.white,
                          onPressed: () async {
                            await audioButton();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: camera
                              ? Icon(Icons.videocam)
                              : Icon(Icons.videocam_off),
                          color: Colors.white,
                          onPressed: () async {
                            await cameraButton();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Buttons(
                    txts: 'Whiteboard',
                  ),
                  Buttons(
                    txts: 'Pen',
                  ),
                  Buttons(
                    txts: 'Color',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        leave();
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'End Class',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                          ),
                        ),
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(25),
                          color: Color(0xffC4C4C4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid.isNotEmpty) {
      return ListView.builder(
        itemCount: _remoteUid.length,
        itemBuilder: ((context, index) => Tooltip(
              message: _remoteUid[index]!.toString(),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedRemoteUser = _remoteUid[index]!;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 54, 63, 97),
                    ),
                    width: 100,
                    height: 100,
                    child: RtcRemoteView.SurfaceView(
                      uid: _remoteUid[index]!,
                      channelId: 'test',
                    ),
                  ),
                ),
              ),
            )),
      );
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}

class Buttons extends StatelessWidget {
  final String txts;
  const Buttons({
    Key? key,
    required this.txts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Center(
          child: Text(txts, style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        height: 25,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(25),
          color: Color(0xffC4C4C4),
        ),
      ),
    );
  }
}

class Participants extends StatelessWidget {
  final widget;
  const Participants({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Participants')),
      body: widget,
    );
  }
}

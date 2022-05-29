import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_channel.dart' as RtcChannel;
import 'package:http/http.dart' as http;

const appid = "93c6765985654033bf9c6dab27ab09d0";

class AgoraIntialization {
  Future<String> agorainit() async {
    final _engine = await RtcEngine.create(appid);

    var channel = await RtcChannel.RtcChannel.create('20');
    return channel.channelId;
  }
}

class AgoraSDK {
  createClass(title) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://e-conference.000webhostapp.com/wp-json/wl/v1/register_class?title=$title'),
      );
      if (response.statusCode == 200) {
        print('done');
      }
    } catch (e) {
      print(e);
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

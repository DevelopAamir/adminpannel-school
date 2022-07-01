import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

indicator(bool spin) {
  if (spin) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: SpinKitWave(
        color: Colors.black,
      ),
    );
  } else {
    return Container();
  }
}

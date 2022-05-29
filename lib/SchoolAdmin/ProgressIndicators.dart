import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

indicator(bool spin) {
  if (spin) {
    return SpinKitWave(
      color: Colors.black,
    );
  } else {
    return Container();
  }
}

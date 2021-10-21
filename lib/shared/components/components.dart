import 'package:flutter/material.dart';

void navigateAndReplace(context, screen) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}

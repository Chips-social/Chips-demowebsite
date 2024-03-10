import 'package:flutter/material.dart';

double getW(context) {
  return MediaQuery.of(context).size.width;
}

double getH(context) {
  return MediaQuery.of(context).size.height;
}

double getF(context, size) {
  return MediaQuery.of(context).textScaler.scale(size);
}

import 'package:flutter/material.dart';
double mediaWidth(BuildContext context, double scale) => MediaQuery.of(context).size.width * scale;
double mediaHeight(BuildContext context, double scale) => MediaQuery.of(context).size.height * scale;
double mediaPixel(BuildContext context, double scale) => MediaQuery.of(context).devicePixelRatio * scale;
double mediaStateBar(BuildContext context, double scale) => MediaQuery.of(context).padding.top * scale;
double mediaWindow(BuildContext context, double scale) => MediaQuery.of(context).padding.top * scale;

import 'package:flutter/material.dart';
import 'back_module/sqlclient.dart';

void main() async{
  List hi = await sqlget().GetMydicList(user_no: "6");
  print(hi);
}
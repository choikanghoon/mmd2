import 'package:flutter/material.dart';
import 'custom_color.dart';
class Style {
  static ButtonStyle mainButtonStyle1 = ElevatedButton.styleFrom(
    shape:RoundedRectangleBorder(
      borderRadius:BorderRadius.circular(20)
    ),
    backgroundColor: CustomColor().MainColor(),
    foregroundColor: CustomColor().TextColor(),
    elevation: 1,
  );

  static ButtonStyle mainButtonStyle2 = ElevatedButton.styleFrom(
    shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: CustomColor().SubColor(),
    foregroundColor: CustomColor().TextColor(),
    elevation: 1,
  );

  static ButtonStyle mainButtonStyle3 = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: CustomColor().AccentColor(),
    foregroundColor: CustomColor().TextColor(),
  );
}
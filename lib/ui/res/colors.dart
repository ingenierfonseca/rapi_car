import 'package:flutter/widgets.dart';

const Color kPrimaryColor = Color(0xFF003057);
const Color kAccentColor = Color(0xFFC8102E);

const Color kBottomNavColor = Color(0xFF185174);
const Color kBottomNavColorPesos = Color(0xFF0E948E);

const Color kFieldFillColor = Color(0xFFF1F1F1);
const Color kFieldErrorBorderColor = kAccentColor;

const Color kLabelTextColor = kPrimaryColor;
const Color kFieldHintTextColor = Color(0xFF505050);
const Color kFieldErrorTextColor = kAccentColor;
const Color kAmountTextColor = Color(0xFFFF5B3E);

const Color kLineTitleColor = kPrimaryColor;
const Color kTotalTitleColor = Color(0xFF707070);

const Color kBackgroundItemColor = Color(0xFFE4E4E4);
const Color kBackgroundSelectedItemColor = Color(0xFF7998AC);

const Color kSuccessfulLabelColor = Color(0xFF147626);

const Color kBorderSecondaryCard = Color(0xFF7998AC);
const Color kShadowSecondaryCard = Color(0xFFDCE3E9);
const Color kBorderButtonBiccosPayColor = Color(0xFFAFC0CD);

const Color kLineColor = Color(0xFFB7B7B7);

const Color kPlaceholderColor = Color(0xFFE4E4E4);

class BiccosColors {
  static final Color biccosRedColor = Color.fromRGBO(200, 16, 46, 1);
  static final Color biccosBlueColor = Color.fromRGBO(0, 48, 87, 1);
  static final Color biccosGrayColor = Color.fromRGBO(112, 112, 112, 0.25);
  static final Color biccosGrayColorOpacity40 =
      Color.fromRGBO(241, 241, 241, 1);
  static final Color biccosGrayColor143 = Color.fromRGBO(143, 143, 143, 1);
  static final Color biccosGrayColorShadow = Color.fromRGBO(0, 48, 87, 1);
  static final Color biccosPayBGColor = Color.fromRGBO(225, 225, 228, 1);
  static final Color cardGreenShadowColor = Color.fromRGBO(135, 174, 136, 0.75);
  static final Color biccosBorderCategoriesColor =
      Color.fromRGBO(0, 48, 87, 0.50);
  static final Color biccosButtonBgColor = Color.fromRGBO(40, 81, 113, 1);

  static final Color borderLineRed = Color.fromRGBO(200, 16, 46, 1);
  static final Color borderGrayOpacity = Color.fromRGBO(0, 48, 87, 0.50);

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
import 'package:shared_preferences/shared_preferences.dart';

const kThemeStyleKey = 'themeStyle';
const kLocaleKey = 'locale';
const kLocaleAsInSystem = 'localeAsSystem';
const kLeftCornerButtonType = 'leftCornerButtonType';
const kRightCornerButtonType = 'rightCornerButtonType';
const kVibrationPreferences = 'vibrationPreferences';
const kIsFirstLaunch = 'isFirstLaunch';
const kIsTimeProgressVisible = 'isTimeProgressVisible';
const kTimeProgressType = 'kTimeProgressType';

late final SharedPreferences sharedPreferences;

Future initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

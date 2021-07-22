import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/app_constants.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/user_applications_controller.dart';
import '../../../shared_widget/leafy_spacer.dart';
import '../../../shared_widget/themed_get_widget.dart';
import '../../../shared_widget/touchable_text_button.dart';
import '../../../utils/enum/leafy_theme_style.dart';
import '../../../utils/enum/user_selected_app_type.dart';
import '../../home/widget/user_app_button.dart';

class LeftAndRightAppsList
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  static const double _spacerMultipler = 4.0;

  const LeftAndRightAppsList({Key? key}) : super(key: key);

  GetBuilder _getBuilderForApp(UserSelectedAppType type, LeafyTheme theme) {
    return GetBuilder<UserApplicationsController>(
      id: controller.getBuilderId(type),
      init: controller,
      builder: (controller) {
        return UserAppButton(
          application: controller.getApp(type),
          onTapped: (application) {
            controller.selectApp(type);
          },
          onLongPress: () {
            controller.selectApp(type);
          },
          textStyle: theme.bodyText2.copyWith(color: theme.foregroundColor),
        );
      },
    );
  }

  String _themeToString(LeafyTheme theme) {
    switch (theme.style) {
      case LeafyThemeStyle.light:
        return 'Light';
      case LeafyThemeStyle.dark:
        return 'Dark';
    }
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To Left App',
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          const LeafySpacer(),
          _getBuilderForApp(UserSelectedAppType.left, theme),
          const LeafySpacer(multipler: _spacerMultipler),
          Text(
            'To Right App',
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          const LeafySpacer(),
          _getBuilderForApp(UserSelectedAppType.right, theme),
          const LeafySpacer(multipler: _spacerMultipler),
          Text(
            'Theme',
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          TouchableTextButton(
            text: _themeToString(theme),
            style: theme.bodyText1,
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            onTap: controller.changeTheme,
          )
        ],
      ),
    );
  }
}

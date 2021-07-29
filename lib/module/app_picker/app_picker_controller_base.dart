import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/user_selected_app_type.dart';

abstract class AppPickerControllerBase extends StatusControllerBase {
  AppPickerControllerBase({
    this.selectOnFirstMatch = false,
    this.type,
  });

  static const selectOnFirstMatchParameter = 'selectOnFirstMatch';
  static const appListBuilderKey = 'appListBuilderKey';

  @protected
  late final InstalledApplicationsService installedApplicationsService;
  late final UserApplicationsController _userApplicationsController;

  late final TextEditingController textEditingController;
  late final FocusNode textFocusNode;
  late final ScrollController scrollController;

  late Iterable<Application> _apps;

  Iterable<Application> get apps => _apps;

  final UserSelectedAppType? type;
  final bool selectOnFirstMatch;

  @override
  Future resolveDependencies() async {
    installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() async {
    await _userApplicationsController.ensureLoaded;
    await installedApplicationsService.ensureInitialized;

    textEditingController = TextEditingController();
    textEditingController.addListener(_onTypedText);

    scrollController = ScrollController();
    scrollController.addListener(_onScrolled);

    textFocusNode = FocusNode();

    _apps = installedApplicationsService.installedApps;

    return super.load();
  }

  void _onTypedText() {
    final value = textEditingController.text;

    final searchApps = installedApplicationsService.installedApps.where(
      (item) => item.name.toLowerCase().contains(value.toLowerCase()),
    );

    if (selectOnFirstMatch && searchApps.length == 1) {
      onAppSelected(searchApps.first);

      return;
    }

    _apps = searchApps;

    update([appListBuilderKey]);
  }

  void _onScrolled() {
    if (scrollController.position.pixels <= .0) {
      if (!textFocusNode.hasFocus) {
        textFocusNode.requestFocus();
      }

      return;
    }

    if (textFocusNode.hasFocus) {
      textFocusNode.unfocus();
    }
  }

  Future onAppSelected(Application app);

  @override
  void onClose() {
    textEditingController.dispose();

    super.onClose();
  }

  void clearInput() {
    textFocusNode.unfocus();
    textEditingController.clear();
    scrollController.jumpTo(.0);
  }
}

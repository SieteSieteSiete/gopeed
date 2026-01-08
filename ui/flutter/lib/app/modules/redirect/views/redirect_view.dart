import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/log_util.dart';
import '../controllers/redirect_controller.dart';

class RedirectArgs {
  final String page;
  final dynamic arguments;

  RedirectArgs(this.page, {this.arguments});
}

class RedirectView extends GetView<RedirectController> {
  const RedirectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final redirectArgs = Get.rootDelegate.arguments() as RedirectArgs;
    logger.i('=== RedirectView.build ===');
    logger.i('Target page: ${redirectArgs.page}');
    logger.i('Arguments type: ${redirectArgs.arguments.runtimeType}');
    logger.i('Arguments: ${redirectArgs.arguments}');
    // Waiting for previous page controller to delete, avoid deleting controller that route page after redirect
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      logger.i('PostFrameCallback: Starting 350ms delay...');
      await Future.delayed(const Duration(milliseconds: 350));
      logger.i('PostFrameCallback: Delay complete, navigating to: ${redirectArgs.page}');
      Get.rootDelegate
          .offAndToNamed(redirectArgs.page, arguments: redirectArgs.arguments);
      logger.i('Navigation command sent');
    });
    logger.i('==========================');
    return const SizedBox();
  }
}

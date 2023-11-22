import 'package:ecom_3/app/routes/app_pages.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await Memory.clear();
            Get.offAllNamed(Routes.LOGIN);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
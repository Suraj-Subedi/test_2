import 'package:ecom_3/app/components/doctor_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mero Doctor'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getSpecializations();
          await controller.getDoctors();
        },
        child: SingleChildScrollView(
          physics: const ScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.specializationResponse == null ||
                  controller.doctorsResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Specializations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.specializationResponse
                                ?.specalizations?.length ??
                            0,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue.withOpacity(0.7),
                          ),
                          margin: const EdgeInsets.only(
                            right: 10,
                            top: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              controller.specializationResponse
                                      ?.specalizations?[index].title ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Top Doctors',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.6,
                      ),
                      itemCount:
                          controller.doctorsResponse?.doctors?.length ?? 0,
                      itemBuilder: (context, index) {
                        return DoctorCard(
                            doctor:
                                controller.doctorsResponse!.doctors![index]);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

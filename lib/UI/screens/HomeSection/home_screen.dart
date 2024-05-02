import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luvit/Infrastructure/common/color_constant.dart';
import 'package:luvit/Infrastructure/common/controller_id.dart';
import 'package:luvit/Infrastructure/common/image_constant.dart';
import 'package:luvit/Infrastructure/model/response/data_model.dart';
import 'package:luvit/UI/commons/text_widgets/base/headline_body_one_base_widget.dart';
import 'package:luvit/UI/screens/HomeSection/home_controller.dart';
import 'package:luvit/UI/screens/HomeSection/widget/details_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: ControllerId.homeScreenKey,
      init: HomeController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: ColorConstant.background,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: ColorConstant.background,
        ),
        body: Column(
          children: [
            ///appbar
            Container(
              padding: const EdgeInsets.all(11),
              child: Row(
                children: [
                  SvgPicture.asset(
                    ImageConstant.homeLocationIcon,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: HeadlineBodyOneBaseWidget(
                      title: "목이길어슬픈기린님의 새로운 스팟",
                      titleColor: ColorConstant.white,
                      fontSize: 14,
                      maxLine: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.border),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageConstant.selectedStar),
                        const SizedBox(width: 4),
                        HeadlineBodyOneBaseWidget(
                          title: "323,233",
                          titleColor: ColorConstant.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstant.notification,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 4,
                            width: 4,
                            decoration: BoxDecoration(
                              color: ColorConstant.pink,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///body
            const SizedBox(height: 20),

            StreamBuilder(
                stream: FirebaseDatabase.instance.ref("data").onValue,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final data = dataModelFromJson(jsonEncode(snapshot.data?.snapshot.value));
                    // log(jsonEncode(snapshot.data?.snapshot.value));
                    controller.keysDataList.clear();
                    data.toJson().keys.forEach((element) {
                      controller.keysDataList.add(element);
                    });
                    List<DetailsDataModel> dataList = data.toJson().values.map((e) => DetailsDataModel.fromJson(e)).toList();
                    return Expanded(
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: dataList.length,
                        onPageChanged: (value) {
                          controller.currentPage.value = value;
                          controller.update([ControllerId.homeScreenKey]);
                        },
                        itemBuilder: (context, index) {
                          return DetailsCard(
                            data: dataList[index],
                            index: controller.currentPage.value,
                            onLikeTap: () async{
                              int likeCount = dataList[index].likeCount ?? 0;
                              if(!controller.likedDataList.contains(dataList[index].name)){
                                await controller.setLikeData(likeCount: (likeCount + 1),name: controller.keysDataList[index]);
                                controller.likedDataList.add(dataList[index].name ?? "");
                              }
                            },
                          );
                        },
                      ),
                    );
                  } else{
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.pink,
                        ),
                      ),
                    );
                  }
                },
              ),

            const SizedBox(height: 40),
            ],
        ),
      );
    },
    );
  }
}

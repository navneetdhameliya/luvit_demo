import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool isLiked = false.obs;

  RxInt currentPage = 0.obs;
  PageController pageController = PageController(viewportFraction: .9, keepPage: true);

  RxList<String> likedDataList = <String>[].obs;
  RxList<String> keysDataList = <String>[].obs;

  setLikeData({required int likeCount,required String name})async{
    // likeCount
    DatabaseReference ref = FirebaseDatabase.instance.ref("data/$name");
    await ref.update({
      "likeCount": likeCount,
    });
  }
}
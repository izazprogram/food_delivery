import 'package:flutter/material.dart';
import 'package:food_delivery/Home/food_pagr_body.dart';
import 'package:food_delivery/utiks/colors.dart';
import 'package:food_delivery/utiks/dimensions.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';

import '../utiks/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //print("current height is "+MediaQuery.of(context).size.height.toString());
    return Scaffold(
        body: Column(
      children: [
        //showing the header
        Container(
          margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
          padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                   BigText(text: "Bangladesh",color: AppColors.mainColor,),
                  Row(
                    children: [
                      SmallText(text: 'Habigonj',color: Colors.black,),
                      Icon(Icons.arrow_drop_down),
                    ],
                  )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                     size: Dimensions.iconSize20
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        //showing the body and header below
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        ))
      ],
    ));
  }
}

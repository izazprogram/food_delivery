import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utiks/colors.dart';
import 'package:food_delivery/utiks/dimensions.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/icon_and_text.dart';
import 'package:food_delivery/widget/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        Container(
          // color: Color(0xed942970),
          height: Dimensions.pageVeiw,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        //dot slide
        new DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        //Popular text section
        SizedBox(
          height: Dimensions.height20,
        ),

        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                child: SmallText(
                  text: "Food Pairing",
                ),
              )
            ],
          ),
        ),

        //List of food  and image
        ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      bottom: Dimensions.width10),
                  child: Row(

                    children: [
                      //image section

                      Container(
                        width:120,
                        height:130,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/bar1.png"),
                            )),
                      ),

                      //text container

                      Expanded(
                        child: Container(

                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                 topRight: Radius.circular(Dimensions.radius15),
                                bottomRight: Radius.circular(Dimensions.radius20)

                            ),
                            color: Colors.white,
                          ),

                          child: Padding(padding: EdgeInsets.only(left:5),
                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: Dimensions.height15,),
                                  BigText(text: "Nutritious fruit meal inb China"),
                                  SizedBox(height: Dimensions.height15,),
                                  SmallText(text: "With chinese charaterristics"),
                                  SizedBox(height: Dimensions.height15,),

                          //row and icon
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // cunnect to the icon_and text dart file
                                      IconAnfTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      IconAnfTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: AppColors.mainColor),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      IconAnfTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        
      ],
    );
  }

  Widget _buildPageItem(int index) {
//position change
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      //round
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bar1.png"),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Chinese Side"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                            );
                          }),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SmallText(text: "4.5"),
                        SizedBox(
                          width: 8,
                        ),
                        SmallText(text: "1287"),
                        SizedBox(
                          width: 8,
                        ),
                        SmallText(text: "comments"),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // cunnect to the icon_and text dart file
                        IconAnfTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        SizedBox(
                          width: 8,
                        ),
                        IconAnfTextWidget(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor),
                        SizedBox(
                          width: 8,
                        ),
                        IconAnfTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

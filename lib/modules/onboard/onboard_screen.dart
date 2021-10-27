import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class OnBoardingModel {
  String image;
  String title;
  String body;

  OnBoardingModel({@required this.image, @required this.title, @required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  List<OnBoardingModel> boardingItems = [
    OnBoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Boarding 1 Title", body: "On Boarding 1 Body"),
    OnBoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Boarding 2 Title", body: "On Boarding 2 Body"),
    OnBoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Boarding 3 Title", body: "On Boarding 3 Body"),
  ];
  var boardingController = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
                  navigateAndFinish(context, LoginScreen());
                });

              },
              child: Text(
                "Skip",
                style: TextStyle(color: primaryColor),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => onBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boardingItems.length - 1) {
                    lastPage = true;
                  } else {
                    lastPage = false;
                    //print("Before Last Page");
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: primaryColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (lastPage) {
                      navigateAndFinish(context, LoginScreen());
                    } else {
                      boardingController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget onBoardingItem(OnBoardingModel model) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text('${model.title}',
          style: TextStyle(
            fontSize: 24,
          )),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ]);

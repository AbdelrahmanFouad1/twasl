import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:twasl/modules/login/login_screen.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class BoardingModel {
  late String image;
  late String title;
  late String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/boarding1.png',
      title: 'Communicate with other',
      body: 'Constructive communication with each other to reach something and everyone will benefit.',
    ),
    BoardingModel(
      image: 'assets/images/boarding2.png',
      title: 'See all new',
      body: 'All new with us and exclusively the latest updates and interactions that took place around you.',
    ),
    BoardingModel(
      image: 'assets/images/boarding3.png',
      title: 'Friends\' photos',
      body: 'Friends\' pictures are in front of you and you can interact with them by liking the posted picture.',
    ),
    BoardingModel(
      image: 'assets/images/boarding4.png',
      title: 'chat with friends',
      body: 'You can chat and learn about the latest news from friends to receive all new and interact with them.',
    ),
    BoardingModel(
      image: 'assets/images/boarding5.png',
      title: 'Edit profile',
      body: 'The profile enjoys flexibility, you can change the profile picture and also modify all data entered.',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.white30,
                    activeDotColor: defaultColor,
                    dotHeight: 8,
                    expansionFactor: 2.5,
                    dotWidth: 10,
                    spacing: 3.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    IconBroken.Arrow___Right_2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '${model.title}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    '${model.body}',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'janna',
                    ),
                  ),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      );
}

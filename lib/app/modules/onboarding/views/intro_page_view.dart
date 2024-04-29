import 'package:flutter/material.dart';

import 'package:get/get.dart';

class IntroPageView extends GetView {
  final String imageURL;
  final String title;
  final String desc;
  IntroPageView(this.imageURL, this.title, this.desc, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Spacer(flex: 3),
          const SizedBox(
            height: 200,
          ),
          Container(
            height: 290,
            width: 400,
            child: Image.asset(
              imageURL,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            desc,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

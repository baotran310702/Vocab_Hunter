import 'package:english_learner/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HeaderInformations extends StatefulWidget {
  const HeaderInformations({super.key});

  @override
  State<HeaderInformations> createState() => _HeaderInformationsState();
}

class _HeaderInformationsState extends State<HeaderInformations> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Assets.icons.logoText.image(
                  width: 140,
                  height: 80,
                ),
              ),
              Stack(
                children: [
                  Assets.icons.bell.image(
                    width: 24,
                    height: 24,
                  ),
                  const Positioned(
                    top: -2.5,
                    right: 3,
                    child: Text(
                      "6",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const Text(
            "Welcome to English Learner",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Have a nice day!",
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

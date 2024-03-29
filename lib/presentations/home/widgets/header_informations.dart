import 'package:english_learner/gen/assets.gen.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class HeaderInformations extends StatefulWidget {
  final String description;
  final String title;
  const HeaderInformations({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<HeaderInformations> createState() => _HeaderInformationsState();
}

class _HeaderInformationsState extends State<HeaderInformations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundAppbar,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppIcons.logoText,
                width: 180,
                height: 80,
              ),
              Stack(
                children: [
                  Assets.icons.bell.image(
                    width: 36,
                    height: 36,
                  ),
                  const Positioned(
                    top: -0.5,
                    right: 6.5,
                    child: Text(
                      "6",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: AppColors.titleHeaderColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.description,
            style: TextStyle(
              color: AppColors.descriptionHeaderColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

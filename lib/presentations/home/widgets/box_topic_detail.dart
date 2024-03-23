import 'package:english_learner/gen/assets.gen.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class BoxTopicDetail extends StatefulWidget {
  const BoxTopicDetail({
    super.key,
    required this.boxHeight,
    required this.radius,
  });

  final double boxHeight;
  final double radius;

  @override
  State<BoxTopicDetail> createState() => _BoxTopicDetailState();
}

class _BoxTopicDetailState extends State<BoxTopicDetail> {
  double scale = 0.6;

  void handleScale() async {
    setState(() {
      scale = 0.8;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      scale = 0.6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: widget.boxHeight,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: widget.boxHeight / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.radius),
                    topRight: Radius.circular(widget.radius),
                  ),
                ),
              ),
              Container(
                height: widget.boxHeight / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xfff0f0f0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(widget.radius),
                    bottomRight: Radius.circular(widget.radius),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Title Topics",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Detail topic",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffe0e0e0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "160 words",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffe0e0e0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                          ),
                          child: Assets.icons.start.image(
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.secondaryBackgroundButton,
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(120, 40),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: AppColors.primaryBackgroundButton,
                                width: 1,
                              ), // Adjust color and width as needed
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Flash Card",
                            style:
                                TextStyle(color: AppColors.secondaryTextButton),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryBackgroundButton,
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(120, 40),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "All Words",
                            style: TextStyle(
                              color: AppColors.primaryTextButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: widget.boxHeight / 2 - (52 / 2),
            right: 10,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    handleScale();
                  },
                  child: AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 200),
                    child: Assets.icons.heart.image(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

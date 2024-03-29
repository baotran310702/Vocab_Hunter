import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class ItemTypeVocab extends StatefulWidget {
  final String text;
  final Widget icon;
  final Function onTap;
  final bool? isAbleToEdit;
  final bool? isSync;
  const ItemTypeVocab({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isAbleToEdit,
    this.isSync,
  });

  @override
  State<ItemTypeVocab> createState() => _ItemTypeVocabState();
}

class _ItemTypeVocabState extends State<ItemTypeVocab> {
  double scale = 1;

  void handleScale() async {
    setState(() {
      scale = 1.2;
    });
    await Future.delayed(const Duration(milliseconds: 140));
    setState(() {
      scale = 1;
    });
    await Future.delayed(const Duration(milliseconds: 80));

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleScale();
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isAbleToEdit != null && widget.isAbleToEdit == true
                ? AppColors.backgroundEditButton
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 95,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isSync != null && widget.isSync == true
                  ? CircularProgressIndicator(
                      color: AppColors.backgroundEditButton,
                    )
                  : widget.icon,
              const SizedBox(height: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: AppColors.mainTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

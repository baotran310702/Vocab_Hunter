import 'package:english_learner/presentations/practise_vocab/widgets/custom_drop_down.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:flutter/material.dart';

class AddAchievementDialog extends StatefulWidget {
  const AddAchievementDialog({super.key});

  @override
  State<AddAchievementDialog> createState() => _AddAchievementDialogState();
}

class _AddAchievementDialogState extends State<AddAchievementDialog> {
  AchievementType selectedAchievementType = AchievementType.capyEating;
  List<String> customTypeAchievement =
      CustomAchievement.values.map((e) => e.value.toString()).toList();

  @override
  Widget build(BuildContext context) {
    List<AchievementType> listAchievementType = AchievementType.values
        .where((element) => element != AchievementType.capyBathing)
        .toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      ///TODO: handle max width
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add New Achievement",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Choose a avatar",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: listAchievementType
                  .map((e) => ImageBox(
                        achievementType: e,
                        isSelected: e == selectedAchievementType,
                        handleSelectedAchievementType:
                            _handleSelectedAchievement,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Description",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Description",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
            ),
            textAlign: TextAlign.start,
          ),
          const Text(
            "Total",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Total",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.textInputs, width: 1.0),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Choose Type Achievement",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          CustomDropDown(
            onChanged: (value) {},
            listItem:
                customTypeAchievement.isNotEmpty ? customTypeAchievement : [],
            customWidth: MediaQuery.of(context).size.width * 0.7,
            marginTop: 12,
            paddingTopIcon: 32,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.3,
                    52,
                  ),
                  backgroundColor: AppColors.titleHeaderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "ADD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.3,
                    52,
                  ),
                  backgroundColor: AppColors.titleHeaderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "CANCLE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _handleSelectedAchievement(AchievementType achievementType) {
    setState(() {
      selectedAchievementType = achievementType;
    });
  }
}

class ImageBox extends StatefulWidget {
  final AchievementType achievementType;
  final bool isSelected;
  final Function(AchievementType) handleSelectedAchievementType;
  const ImageBox({
    super.key,
    required this.achievementType,
    required this.isSelected,
    required this.handleSelectedAchievementType,
  });

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: widget.isSelected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              widget.handleSelectedAchievementType(widget.achievementType);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.titleHeaderColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 100,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Center(
                child: Image.asset(
                  CustomConverter.convertAchievement(
                    widget.achievementType,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

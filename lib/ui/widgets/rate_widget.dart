import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';

class Rate extends StatefulWidget {
  final ValueChanged<int?> onSelect;
  const Rate({super.key, required this.onSelect});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  final rates = [
    AppAsset.rate1,
    AppAsset.rate2,
    AppAsset.rate3,
    AppAsset.rate4,
    AppAsset.rate5,
  ];
  int? selectedRating;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rates
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Clickable(
                onPressed: () {
                  setState(() {
                    selectedRating = rates.indexOf(e);
                    if (selectedRating != null) {
                      widget.onSelect(selectedRating! + 1);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedRating == rates.indexOf(e)
                        ? ColorPath.funGreen
                        : ColorPath.taraGreen,
                  ),
                  child: Image.asset(e, height: 42.h, width: 42.w),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

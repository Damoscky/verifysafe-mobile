import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../custom_button.dart';

class SortOptions extends StatefulWidget {
  final ValueChanged<String> onSelected;
  final List<String> filterOptions;
  final String? initialValue;
  const SortOptions({super.key, required this.onSelected, this.initialValue, required this.filterOptions});

  @override
  State<SortOptions> createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {

  String? _selected;

  @override
  void initState() {
    _selected  = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppDimension.paddingTop,
          horizontal: AppDimension.bottomSheetPaddingRight
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort by',
                style:textTheme
                    .titleMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.textPrimary
                ),
              ),
              Clickable(
                onPressed: (){
                  setState(() {
                    _selected = null;
                  });
                },
                child: Text(
                  'Clear',
                  style:textTheme
                      .bodyLarge
                      ?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.textSecondary
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          ListView.separated(
            itemCount: widget.filterOptions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final label = widget.filterOptions[index];
              final isSelected = label.toLowerCase() == _selected?.toLowerCase();
              return Clickable(
                onPressed: (){
                  setState(() {
                    _selected = label;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: isSelected ? FontWeight.w700:FontWeight.w400,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? ColorPath.meadowGreen : Theme.of(context).colorScheme.textTertiary
                      ),
                      child: isSelected ? Center(
                        child: Container(
                          height: 16.h,
                          width: 16.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:Colors.white
                          ),
                        ),
                      ):SizedBox.shrink(),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h,);
            },
          ),
          SizedBox(height: 40.h,),
          CustomButton(
              buttonText: 'Done',
              onPressed: (){
                if(_selected == null){
                  showFlushBar(
                      context: context,
                      message: 'Kindly select a sort option to proceed',
                    success: false
                  );
                  return;
                }

                  widget.onSelected(_selected!);
                popNavigation(context: context);
              }
          ),

        ],
      ),
    );
  }
}

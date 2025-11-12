import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/tag_type.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/naira_display.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class BillType extends ConsumerStatefulWidget {
  const BillType({super.key});

  @override
  ConsumerState<BillType> createState() => _BillTypeState();
}

class _BillTypeState extends ConsumerState<BillType> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Plan Type",
        showBottom: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32.h),
          CustomTabSwitcher(
            initialValue: true,
            onChanged: (isMonthly) {
              setState(() {
                if (isMonthly) {
                  tabIndex = 0;
                } else {
                  tabIndex = 1;
                }
              });
            },
          ),
          buildTabContent(tabIndex),
          SizedBox(height: 32.h),
          if (1 + 1 == 2) // show when selected
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimension.paddingLeft,
                vertical: 32.h,
              ),
              child: CustomButton(onPressed: () {}, buttonText: "Pay N 1,000"),
            ),
        ],
      ),
    );
  }

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimension.paddingRight,
              vertical: 16.h,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SubscriptionItem(
                  isSelected: index == 0,
                  isCurrentPlan: index == 0,
                  isPopular: index == 1,
                  headerColor: index == 1
                      ? ColorPath.niagaraGreen
                      : ColorPath.athensGrey2,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: 3,
            ),
          ),
        );
      case 1:
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimension.paddingRight,
              vertical: 16.h,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SubscriptionItem(
                  isSelected: index == 0,
                  isCurrentPlan: index == 0,
                  isPopular: index == 1,
                  headerColor: index == 1
                      ? ColorPath.niagaraGreen
                      : ColorPath.athensGrey2,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: 3,
            ),
          ),
        );

      default:
        return Container();
    }
  }
}

//widgets
class SubscriptionItem extends StatefulWidget {
  final bool isSelected;
  final bool isCurrentPlan;
  final bool isPopular;

  final Color? headerColor;

  const SubscriptionItem({
    super.key,
    this.isSelected = false,
    this.isCurrentPlan = false,
    this.isPopular = false,
    this.headerColor,
  });

  @override
  State<SubscriptionItem> createState() => _SubscriptionItemState();
}

class _SubscriptionItemState extends State<SubscriptionItem> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return VerifySafeContainer(
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: widget.isSelected ? ColorPath.niagaraGreen : Colors.transparent,
        width: 2,
      ), // selection outline
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: widget.headerColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Basic",
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        color: colorScheme.text5,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (widget.isPopular)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.w,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: ColorPath.athensGrey2,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text("Popular"),
                      ),
                  ],
                ),
                Container(
                  height: 24.h,
                  width: 24.h,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? ColorPath.meadowGreen
                        : ColorPath.mysticGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    height: 24.h,
                    width: 24.h,
                    decoration: BoxDecoration(
                      color: ColorPath.mysticGrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: widget.isCurrentPlan ? ColorPath.aquaGreen : null,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "With this plan you get access to 1 worker entry & search",
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NairaDisplay(
                      amount: 1000,
                      color: ColorPath.niagaraGreen,
                      fontSize: 16.sp,
                    ),
                    if (widget.isCurrentPlan)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.w,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: ColorPath.athensGrey2,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text("Current Plan"),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabSwitcher extends StatefulWidget {
  final Function(bool isMonthly)? onChanged;
  final bool initialValue;

  const CustomTabSwitcher({
    super.key,
    this.onChanged,
    this.initialValue = true,
  });

  @override
  State<CustomTabSwitcher> createState() => _CustomTabSwitcherState();
}

class _CustomTabSwitcherState extends State<CustomTabSwitcher>
    with SingleTickerProviderStateMixin {
  late bool isMonthly;
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isMonthly = widget.initialValue;

    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    if (!isMonthly) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle(bool value) {
    if (isMonthly == value) return;

    setState(() {
      isMonthly = value;
    });

    if (value) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return VerifySafeContainer(
      width: 175.w,
      borderRadius: BorderRadius.circular(20.r),
      padding: EdgeInsets.all(6.w),
      border: Border.all(color: ColorPath.mintTulip),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final containerWidth = 175.w - 12.w;
          final halfWidth = (containerWidth - 12.w) / 2;

          return Stack(
            children: [
              // Animated sliding background with scale
              Positioned(
                left: _slideAnimation.value * (halfWidth + 12.w),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: halfWidth,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: ColorPath.niagaraGreen,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                ),
              ),
              // Text options
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggle(true),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        color: Colors.transparent,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 300),
                            style: TextStyle(
                              color: isMonthly
                                  ? Colors.white
                                  : ColorPath.niagaraGreen,
                              fontWeight: isMonthly
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: isMonthly ? 14.sp : 13.sp,
                            ),
                            child: Text("Monthly"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggle(false),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        color: Colors.transparent,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 300),
                            style: TextStyle(
                              color: !isMonthly
                                  ? Colors.white
                                  : ColorPath.niagaraGreen,
                              fontWeight: !isMonthly
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: !isMonthly ? 14.sp : 13.sp,
                            ),
                            child: Text("Yearly"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

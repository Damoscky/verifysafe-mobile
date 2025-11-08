import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/color_path.dart';

class AnimatedCircularProgress extends StatelessWidget {
  final double percentage; // 0 to 100
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Duration duration;

  const AnimatedCircularProgress({
    super.key,
    required this.percentage,
    this.size = 40,
    this.strokeWidth = 6,
    this.progressColor,
    this.backgroundColor,
    this.textStyle,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // Animated Circular Progress Bar
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: percentage / 100 ), // percentage filler
          duration: duration,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPath.chateauGrey.withOpacity(0.2),
                  ),
                  child: CustomPaint(
                    painter: CircularProgressPainter(
                      progress: value,
                      progressColor: progressColor ??
                          ColorPath.shamrockGreen, // Your progress color
                      backgroundColor: backgroundColor ?? ColorPath.chateauGrey.withOpacity(
                        0.2,
                      ), // Background track color
                      strokeWidth: strokeWidth.w,
                    ),
                    size: Size( size.w, size.h),
                  ),
                ),
                Container(
                  height: 8.h,
                  width: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 8.h),
        // Percentage Text
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: percentage),
          duration: duration,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Text(
              "${value.toInt()}%",
              style: textStyle ?? textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            );
          },
        ),
      ],
    );
  }
}

//widgets:
///Custom Painter
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle =
        -2 * math.pi * progress; // Made negative for anti-clockwise
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

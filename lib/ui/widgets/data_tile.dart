import 'package:flutter/material.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

class DataTile extends StatelessWidget {
  final String title;
  final String data;
  const DataTile({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
        ),
        Text(
          data,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.blackText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

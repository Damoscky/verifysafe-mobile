import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import '../../core/constants/color_path.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String bottomHintText;
  final double? textSize;
  final Color? bottomHintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusPointer;
  final bool showLabel;
  final Color? fillColor;
  final bool enableSearch; // New parameter
  final String searchHintText; // New parameter

  const CustomDropdown({
    super.key,
    this.label = '',
    this.labelSize,
    this.labelFontWeight = FontWeight.w400,
    this.labelColor,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.hintText = '',
    this.bottomHintText = '',
    this.textSize,
    this.bottomHintColor,
    this.enabled = true,
    this.readOnly = false,
    this.isCompulsory = false,
    this.focusPointer,
    this.showLabel = true,
    this.fillColor,
    this.enableSearch = false, // Default to false
    this.searchHintText = 'Search...', // Default search hint
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _errorText;

  void _showSearchableDropdown(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SearchableDropdownModal(
          items: widget.items,
          selectedValue: widget.value,
          onChanged: widget.onChanged,
          hintText: widget.hintText,
          searchHintText: widget.searchHintText,
          textSize: widget.textSize,
          colorScheme: colorScheme,
          textTheme: textTheme,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Row(
            children: [
              Text(
                widget.label,
                style: textTheme.bodyMedium?.copyWith(
                  color: widget.labelColor ?? colorScheme.textFieldLabel,
                  fontWeight: widget.labelFontWeight,
                ),
              ),
              if (widget.isCompulsory) SizedBox(width: 5.w),
              if (widget.isCompulsory)
                Text(
                  '*',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontSize: widget.labelSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (widget.showLabel) SizedBox(height: 6.h),

        // If search is enabled, use GestureDetector to show modal
        widget.enableSearch
            ? GestureDetector(
                onTap: widget.enabled && !widget.readOnly
                    ? () => _showSearchableDropdown(context)
                    : null,
                child: Container(
                  height: 56.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.fillColor ?? colorScheme.textFieldFillColor,
                    border: Border.all(
                      color: _errorText != null
                          ? ColorPath.redOrange
                          : colorScheme.textFieldBorder,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.value ?? widget.hintText,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: widget.textSize?.sp,
                            color: widget.value != null
                                ? colorScheme.textPrimary
                                : colorScheme.textFieldHint,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme.blackText,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 56.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.fillColor ?? colorScheme.textFieldFillColor,
                  border: Border.all(
                    color: _errorText != null
                        ? ColorPath.redOrange
                        : colorScheme.textFieldBorder,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                child: Center(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    focusNode: widget.focusPointer,
                    value: widget.value,
                    validator: (value) {
                      if (widget.validator != null) {
                        final error = widget.validator!(value);
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _errorText = error;
                          });
                        });
                      }
                      return null;
                    },
                    onChanged: widget.enabled && !widget.readOnly
                        ? widget.onChanged
                        : null,
                    decoration: InputDecoration(
                      errorText: null,
                      errorMaxLines: 3,
                      hintText: widget.hintText,
                      hintStyle: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colorScheme.textFieldHint,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 0.w),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme.blackText,
                        size: 20.w,
                      ),
                    ),
                    items: widget.items.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: widget.textSize?.sp,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.textPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: widget.textSize?.sp,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.textPrimary,
                    ),
                  ),
                ),
              ),
        if (widget.bottomHintText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              widget.bottomHintText,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: widget.bottomHintColor ?? colorScheme.textPrimary,
              ),
            ),
          ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              _errorText!,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}

// Searchable Dropdown Modal Widget
class SearchableDropdownModal extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final String searchHintText;
  final double? textSize;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const SearchableDropdownModal({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    required this.hintText,
    required this.searchHintText,
    this.textSize,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  State<SearchableDropdownModal> createState() =>
      _SearchableDropdownModalState();
}

class _SearchableDropdownModalState extends State<SearchableDropdownModal> {
  late TextEditingController _searchController;
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _filteredItems = widget.items
          .where(
            (item) => item.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: widget.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Search field
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              cursorColor: widget.colorScheme.textFieldHint,
              decoration: InputDecoration(
                hintText: widget.searchHintText,
                hintStyle: widget.textTheme.bodyMedium?.copyWith(
                  color: widget.colorScheme.textFieldHint,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: widget.colorScheme.textFieldHint,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: widget.colorScheme.textFieldHint,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: widget.colorScheme.textFieldHint,
                    width: 2.w,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),

          // Results list
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style: widget.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = item == widget.selectedValue;

                      return ListTile(
                        title: Text(
                          item,
                          style: widget.textTheme.bodyLarge?.copyWith(
                            fontSize: widget.textSize?.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? widget.colorScheme.brandColor
                                : widget.colorScheme.textPrimary,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: widget.colorScheme.brandColor,
                                size: 20.w,
                              )
                            : null,
                        onTap: () {
                          widget.onChanged?.call(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

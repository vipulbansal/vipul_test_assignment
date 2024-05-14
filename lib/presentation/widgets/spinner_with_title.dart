import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipul_test_assignment/commons/theme/app_theme.dart';

class CustomSpinner<T> extends StatefulWidget {
  final List<T> allItems;
  final Function onChanged;
  final VoidCallback? onForcedNull;
  final T? initialSelected;
  final String? hint;
  final String? topTitle;

  const CustomSpinner({
    super.key,
    required this.allItems,
    required this.onChanged,
    this.initialSelected,
    this.hint,
    this.onForcedNull,
    this.topTitle,
  });

  @override
  State<CustomSpinner> createState() => _CustomSpinnerState();
}

class _CustomSpinnerState<T> extends State<CustomSpinner> {
  T? _dropDownValue;

  @override
  initState() {
    super.initState();
    if (widget.initialSelected != null) {
      _dropDownValue = widget.initialSelected;
      widget.onChanged(widget.initialSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialSelected == null && widget.onForcedNull != null) {
      _dropDownValue = null;
      widget.onForcedNull!();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.topTitle != null) ...[
          Text(
            widget.topTitle ?? "",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10,
                ),
          ),
          SizedBox(height: 8.0),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppThemeManager.lightGrayColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: AppTheme.white,
          ),
          child: DropdownButton<T>(
            isDense: true,
            padding: EdgeInsets.fromLTRB(16, 6, 4, 6),
            underline: Container(),
            iconEnabledColor: AppThemeManager.appPrimaryColor,
            hint: Text(
              _dropDownValue == null
                  ? (widget.hint ?? "Select")
                  : _dropDownValue.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: _dropDownValue == null
                        ? AppThemeManager.appPrimaryColor
                        : AppThemeManager.secondaryColor,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            isExpanded: true,
            iconSize: 30.0,
            borderRadius: BorderRadius.circular(12),
            style: Theme.of(context).textTheme.titleMedium,
            items: widget.allItems.map(
              (val) {
                return DropdownMenuItem<T>(
                  value: val,
                  child: Text(
                    val.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
            ).toList(),
            onChanged: (val) {
              if (_dropDownValue == val) return;
              widget.onChanged(val);
              setState(
                () {
                  _dropDownValue = val;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

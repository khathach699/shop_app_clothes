import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;
    final color = isColor ? THelperFunctions.getColor(text)! : null;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        avatar:
            isColor
                ? TCircularContainer(
                  width: 50,
                  height: 50,
                  backgroundColor: color ?? Colors.transparent,
                )
                : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        selectedColor: isColor ? color : Colors.blue, // Color when selected
        backgroundColor:
            isColor
                ? (selected
                    ? color
                    : color?.withOpacity(
                      0.6,
                    )) // Keep default color when not selected
                : Colors.grey[200], // Default color when not selected
      ),
    );
  }
}

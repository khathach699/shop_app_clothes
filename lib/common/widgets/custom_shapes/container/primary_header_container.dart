import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurveEdgeWidget(
      child: SizedBox(
        height: 400,
        child: Container(
          color: TColors.primaryColor,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhile.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhile.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

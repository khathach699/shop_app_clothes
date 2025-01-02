import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class TCurveEdgeWidget extends StatelessWidget {
  const TCurveEdgeWidget({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CurvedEdges(), child: child);
  }
}

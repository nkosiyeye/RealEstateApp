import 'package:flutter/material.dart';

import 'curved_edges.dart';

class TCustomEdgeWidget extends StatelessWidget {
  const TCustomEdgeWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
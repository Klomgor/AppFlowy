import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The class for FlowySvgData that the code generator will implement
class FlowySvgData {
  /// The svg data
  const FlowySvgData(
    this.path,
  );

  /// The path to the svg data in appflowy assets/images
  final String path;
}

/// For icon that needs to change color when it is on hovered
///
/// Get the hover color from ThemeData
class FlowySvg extends StatelessWidget {
  /// Construct a FlowySvg Widget
  const FlowySvg(
    this.svg, {
    super.key,
    this.size,
    this.color,
    this.blendMode = BlendMode.srcIn,
  });

  /// The data for the flowy svg. Will be generated by the generator in this
  /// package within bin/flowy_svg.dart
  final FlowySvgData svg;

  /// The size of the svg
  final Size? size;

  /// The color of the svg.
  ///
  /// This property will not be applied to the underlying svg widget if the
  /// blend mode is null, but the blend mode defaults to [BlendMode.srcIn]
  /// if it is not explicitly set to null.
  final Color? color;

  /// The blend mode applied to the svg.
  ///
  /// If the blend mode is null then the icon color will not be applied.
  /// Set both the icon color and blendMode in order to apply color to the
  /// svg widget.
  final BlendMode? blendMode;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).iconTheme.color;

    final child = SvgPicture.asset(
      _normalized(),
      colorFilter:
          iconColor != null && blendMode != null
          ? ColorFilter.mode(
              iconColor,
              blendMode!,
            )
          : null,
    );

    if (size != null) {
      return SizedBox.fromSize(
        size: size,
        child: child,
      );
    }

    return child;
  }

  /// If the SVG's path does not start with `assets/`, it is
  /// normalized and directed to `assets/images/`
  ///
  /// If the SVG does not end with `.svg`, then we append the file extension
  ///
  String _normalized() {
    var path = svg.path;

    if (!path.toLowerCase().startsWith('assets/')) {
      path = 'assets/images/$path';
    }

    if (!path.toLowerCase().endsWith('.svg')) {
      path = '$path.svg';
    }

    return path;
  }
}
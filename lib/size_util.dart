library size_util;

import 'package:flutter/material.dart';

class SizeUntil {
  SizeUntil._();
  static SizeUntil instance = SizeUntil._();
  static final view = WidgetsBinding.instance.platformDispatcher.implicitView;
  static final Size pS = view?.physicalSize ?? sizeDefault;
  static final dR = view?.devicePixelRatio ?? 1;
  static final Size _size = pS / dR;
  static Size get size => _size;
}

Size sizeDefault = const Size(375, 812);

extension NumEx on num {
  Widget get vertical => SizedBox(height: toDouble());

  Widget get horizontal => SizedBox(width: toDouble());

  double get hf => SizeUntil.size.h(sizeDefault) * this;

  double get wf => SizeUntil.size.w(sizeDefault) * this;

  double get u => SizeUntil.size.f(sizeDefault) * this;

  double get rf => SizeUntil.size.f(sizeDefault) * this;

  double height(num size) => u / size.u;

  double textHeight(num size) => this / size;
}

/// without size default [sizeDefault]
extension NumSize on Size {
  double h(Size size) => height / size.height;

  double w(Size size) => width / size.width;

  double f(Size size) =>
      width < height ? width / size.width : height / size.height;
}

class NumContext {
  NumContext(this.numBer, this.numHeight, this.context);
  final double numBer;
  final double numHeight;
  final BuildContext context;
}

extension SizeLayoutContext on BuildContext {
  Size get appSize => MediaQuery.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension VGlobalKey on GlobalKey {
  Offset get position {
    final RenderBox? renderBox =
        currentContext?.findRenderObject() as RenderBox?;
    final NavigatorState? state =
        currentContext?.findAncestorStateOfType<NavigatorState>();
    if (state != null) {
      return renderBox?.localToGlobal(
            Offset.zero,
            ancestor: state.context.findRenderObject(),
          ) ??
          Offset.zero;
    }
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }

  Size get size {
    final RenderBox? renderBox =
        currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }

  double get height => size.height;
}

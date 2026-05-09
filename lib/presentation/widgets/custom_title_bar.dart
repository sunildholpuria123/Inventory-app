import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomTitleBar
    extends StatelessWidget {
  const CustomTitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(),
          ),

          const WindowButtons(),
        ],
      ),
    );
  }
}

final buttonColors =
WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Colors.blue,
  mouseDown: Colors.indigo,
);

class WindowButtons
    extends StatelessWidget {
  const WindowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
        ),

        MaximizeWindowButton(
          colors: buttonColors,
        ),

        CloseWindowButton(
          colors: buttonColors,
        ),
      ],
    );
  }
}
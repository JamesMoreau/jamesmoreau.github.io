import 'package:flutter/material.dart';

typedef OnTabChangedCallback = void Function(int tabIndex);

class CustomTabContainer extends StatefulWidget {
  final int initialTabIndex;
  final OnTabChangedCallback onTabChanged;

  const CustomTabContainer({
    Key? key,
    required this.initialTabIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<CustomTabContainer> createState() => _CustomTabContainerState();
}

class _CustomTabContainerState extends State<CustomTabContainer> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
  }

  void _onTabChanged(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
    });
    widget.onTabChanged(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_currentTabIndex == 0) ...[
          // Page 1 content
          Center(child: Text("Page 1")),
        ],
        if (_currentTabIndex == 1) ...[
          // Page 2 content
          Center(child: Text("Page 2")),
        ],
        // Add more pages as needed
      ],
    );
  }
}
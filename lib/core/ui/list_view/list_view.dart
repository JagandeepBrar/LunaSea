import 'package:flutter/material.dart';

class LunaListView extends StatelessWidget {
    final List<Widget> children;
    final double itemExtent;
    final EdgeInsetsGeometry padding;
    final ScrollPhysics physics;
    final ScrollController controller;

    LunaListView({
        Key key,
        @required this.children,
        @required this.controller,
        this.itemExtent,
        this.padding,
        this.physics = const AlwaysScrollableScrollPhysics(),
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            controller: controller,
            child: ListView(
                controller: controller,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemExtent: itemExtent,
                padding: padding ?? MediaQuery.of(context).padding.add(EdgeInsets.symmetric(vertical: 8.0)),
                physics: physics,
                children: children,
            ),
        );
    }
}

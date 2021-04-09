import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFloatingActionButtonExtended extends StatelessWidget {
    final Color color;
    final Color backgroundColor;
    final IconData icon;
    final String label;
    final void Function() onPressed;
    final Object heroTag;

    LunaFloatingActionButtonExtended({
        Key key,
        @required this.icon,
        @required this.label,
        @required this.onPressed,
        this.backgroundColor = LunaColours.accent,
        this.color = Colors.white,
        this.heroTag,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return FloatingActionButton.extended(
            icon: FaIcon(icon, color: color),
            onPressed: onPressed,
            label: Text(
                label,
                style: TextStyle(
                    color: color,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    letterSpacing: 0.35,
                ),
            ),
            backgroundColor: backgroundColor,
            heroTag: heroTag,
        );
    }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrReleasesSortButton extends StatefulWidget {
    final ScrollController controller;

    LidarrReleasesSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<LidarrReleasesSortButton> createState() => _State();
}

class _State extends State<LidarrReleasesSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<LidarrState>(
            builder: (context, model, widget) => LunaPopupMenuButton<LidarrReleasesSorting>(
                icon: Icons.sort,
                onSelected: (result) {
                    if(model.sortReleasesType == result) {
                        model.sortReleasesAscending = !model.sortReleasesAscending;
                    } else {
                        model.sortReleasesAscending = true;
                        model.sortReleasesType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<LidarrReleasesSorting>>.generate(
                    LidarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<LidarrReleasesSorting>(
                        value: LidarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    LidarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortReleasesType == LidarrReleasesSorting.values[index]) Icon(
                                    model.sortReleasesAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: Constants.UI_FONT_SIZE_SUBTITLE+2.0,
                                    color: LunaColours.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );

    void _scrollBack() {
        widget.controller.animateTo(
            1.00,
            duration: Duration(
                milliseconds: Constants.UI_NAVIGATION_SPEED*2,
            ),
            curve: Curves.easeOutSine,
        );
    }
}

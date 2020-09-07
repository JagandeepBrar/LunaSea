import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNewslettersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Newsletters'),
        subtitle: LSSubtitle(text: 'Tautulli Newsletter Logs'),
        trailing: LSIconButton(
            icon: Icons.email,
            color: LSColors.list(3),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        TautulliLogsNewslettersRoute.route(),
    );
}

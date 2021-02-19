import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrRouter extends LunaPageRouter {
    SettingsConfigurationLidarrRouter() : super('/settings/configuration/lidarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLidarrRoute());
}

class _SettingsConfigurationLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLidarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Lidarr',
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, LunaModule.LIDARR),
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            children: [
                _enabledToggle(),
                _connectionDetailsPage(),
                LunaDivider(),
                _homePage(),
                //_defaultPagesPage(),
            ],
        );
    }

    Widget _enabledToggle() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Enable ${LunaModule.LIDARR.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.lidarrEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.lidarrEnabled = value;
                        Database.currentProfileObject.save();
                    },
                ),
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for Lidarr'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationLidarrConnectionDetailsRouter().navigateTo(context),
        );
    }

    // Widget _defaultPagesPage() {
    //     return LunaListTile(
    //         context: context,
    //         title: LunaText.title(text: 'Default Pages'),
    //         subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
    //         trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
    //         onTap: () async => SettingsConfigurationLidarrDefaultPagesRouter().navigateTo(context),
    //     );
    // }

    Widget _homePage() {
        return LidarrDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Default Page'),
                subtitle: LunaText.subtitle(text: LidarrNavigationBar.titles[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: LidarrNavigationBar.icons[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await LidarrDialogs.defaultPage(context);
                    if(values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }
}
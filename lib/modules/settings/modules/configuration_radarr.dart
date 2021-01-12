import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrRouter extends LunaPageRouter {
    SettingsConfigurationRadarrRouter() : super('/settings/configuration/radarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrRoute());
}

class _SettingsConfigurationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Radarr',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: RadarrConstants.MODULE_METADATA.name,
            message: RadarrConstants.MODULE_METADATA.helpMessage,
            github: RadarrConstants.MODULE_METADATA.github,
            website: RadarrConstants.MODULE_METADATA.website,
        ),
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                ..._customization,
            ],
        ),
    );

    List<Widget> get _configuration => [
        _enabledTile,
        _hostTile,
        _apiKeyTile,
        _customHeadersTile,
        _testConnectionTile,
    ];

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _configDefaultPageTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Radarr'),
        trailing: Switch(
            value: Database.currentProfileObject.radarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.radarrEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _hostTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editHost(
                context,
                'Radarr Host',
                prefill: Database.currentProfileObject.radarrHost ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.radarrHost = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.radarrHost == null || Database.currentProfileObject.radarrHost == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.radarrHost
                ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _apiKeyTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs().editText(
                context,
                'Radarr API Key',
                prefill: Database.currentProfileObject.radarrKey ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.radarrKey = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.radarrKey == null || Database.currentProfileObject.radarrKey == ''
                    ? 'Not Set'
                    : '••••••••••••'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _testConnectionTile {
        //TODO
        return Container();
    }

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationRadarrHeadersRouter().navigateTo(context),
    );

    Widget get _configDefaultPageTile {
        // TODO
        return Container();
    }
}

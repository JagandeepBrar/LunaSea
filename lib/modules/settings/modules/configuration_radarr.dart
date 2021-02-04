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
        _defaultPageHomeTile,
        _defaultPageMovieDetailsTile,
        _defaultPageAddMovieTile,
        LSHeader(text: 'Default Sorting & Filtering'),
        _defaultSortingMoviesTile,
        _defaultSortingMoviesDirectionTile,
        _defaultFilteringMoviesTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Radarr'),
        trailing: LunaSwitch(
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
        // TODO
        // Future<void> _testConnection(BuildContext context) async => await RadarrAPI.from(Database.currentProfileObject).testConnection()
        // .then((_) => showLunaSuccessSnackBar(
        //     context: context,
        //     title: 'Connected Successfully',
        //     message: 'Radarr is ready to use with ${Constants.APPLICATION_NAME}',
        // ))
        // .catchError((error, stack) {
        //     LunaLogger().error('Connection Test Failed', error, stack);
        //     showLunaErrorSnackBar(
        //         context: context,
        //         title: 'Connection Test Failed',
        //         error: error,
        //     );
        // }); 
        return LSButton(
            text: 'Test Connection',
            onTap: null,//_testConnection(context),
        );
        // TODO
    }

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationRadarrHeadersRouter().navigateTo(context),
    );

    Widget get _defaultPageHomeTile => RadarrDatabaseValue.NAVIGATION_INDEX.listen(
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: RadarrNavigationBar.titles[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: RadarrNavigationBar.icons[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await RadarrDialogs.setDefaultPage(context, titles: RadarrNavigationBar.titles, icons: RadarrNavigationBar.icons);
                if(_values[0]) RadarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageMovieDetailsTile => RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.listen(
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Movie Details'),
            subtitle: LSSubtitle(text: RadarrMovieDetailsNavigationBar.titles[RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data]),
            trailing: LSIconButton(icon: RadarrMovieDetailsNavigationBar.icons[RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data]),
            onTap: () async {
                List<dynamic> _values = await RadarrDialogs.setDefaultPage(context, titles: RadarrMovieDetailsNavigationBar.titles, icons: RadarrMovieDetailsNavigationBar.icons);
                if(_values[0]) RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageAddMovieTile => RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.listen(
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Add Movie'),
            subtitle: LSSubtitle(text: RadarrMoviesAddNavigationBar.titles[RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data]),
            trailing: LSIconButton(icon: RadarrMoviesAddNavigationBar.icons[RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data]),
            onTap: () async {
                List<dynamic> _values = await RadarrDialogs.setDefaultPage(context, titles: RadarrMoviesAddNavigationBar.titles, icons: RadarrMoviesAddNavigationBar.icons);
                if(_values[0]) RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.put(_values[1]);
            },
        ),
    );

    Widget get _defaultSortingMoviesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Movies Sort Category'),
            subtitle: LSSubtitle(text: (RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data as RadarrMoviesSorting).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<String> _titles = RadarrMoviesSorting.values.map<String>((e) => e.readable).toList();
                List _values = await RadarrDialogs.setDefaultSortingOrFiltering(context, titles: _titles);
                if(_values[0]) {
                    RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.put(RadarrMoviesSorting.values[_values[1]]);
                    context.read<RadarrState>().moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
                    context.read<RadarrState>().moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
                }
            },
        ),
    );

    Widget get _defaultSortingMoviesDirectionTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Movies Sort Direction'),
            subtitle: LSSubtitle(text: RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data ? 'Ascending' : 'Descending'),
            trailing: LunaSwitch(
                value: RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data,
                onChanged: (value) {
                    RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.put(value);
                    context.read<RadarrState>().moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
                    context.read<RadarrState>().moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
                },
            ),
        ),
    );

    Widget get _defaultFilteringMoviesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Movies Filter Category'),
            subtitle: LSSubtitle(text: (RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data as RadarrMoviesFilter).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<String> _titles = RadarrMoviesFilter.values.map<String>((e) => e.readable).toList();
                List _values = await RadarrDialogs.setDefaultSortingOrFiltering(context, titles: _titles);
                if(_values[0]) {
                    RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.put(RadarrMoviesFilter.values[_values[1]]);
                    context.read<RadarrState>().moviesFilterType = RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data;
                }
            },
        ),
    );
}

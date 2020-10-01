import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSeasonDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/details/:seriesid/season/:seasonnumber';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
        @required int seasonNumber,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(seriesId: seriesId, seasonNumber: seasonNumber),
    );

    static String route({
        @required int seriesId,
        @required int seasonNumber,
    }) => ROUTE_NAME
        .replaceFirst(':seriesid', seriesId.toString())
        .replaceFirst(':seasonnumber', seasonNumber.toString());

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesSeasonDetailsRoute(
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
                seasonNumber: int.tryParse(params['seasonnumber'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesSeasonDetailsRoute extends StatefulWidget {
    final int seriesId;
    final int seasonNumber;

    _SonarrSeriesSeasonDetailsRoute({
        Key key,
        @required this.seriesId,
        @required this.seasonNumber,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesSeasonDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar {
        return LunaAppBar(
            context: context,
            title: 'Season Details',
            popUntil: '/sonarr',
        );
    }
}
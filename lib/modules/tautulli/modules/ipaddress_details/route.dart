import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliIPAddressDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/ipaddress/:ipaddress';

    static Future<void> navigateTo(BuildContext context, {
        @required String ip,
    }) async => TautulliRouter.router.navigateTo(
        context,
        route(ip: ip),
    );

    static String route({
        @required String ip,
        String profile,
    }) => [
        ROUTE_NAME.replaceFirst(':ipaddress', ip ?? '0'),
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliIPAddressRoute(
                ipAddress: params['ipaddress'] != null && params['ipaddress'].length != 0 ? params['ipaddress'][0] : null,
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliIPAddressRoute(
                ipAddress: params['ipaddress'] != null && params['ipaddress'].length != 0 ? params['ipaddress'][0] : null,
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliIPAddressDetailsRouter._();
}

class _TautulliIPAddressRoute extends StatefulWidget {
    final String profile;
    final String ipAddress;

    _TautulliIPAddressRoute({
        @required this.profile,
        @required this.ipAddress,
        Key key,
    }) : super(key: key);

    @override
    State<_TautulliIPAddressRoute> createState() => _State();
}

class _State extends State<_TautulliIPAddressRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.fetchGeolocationInformation(context, widget.ipAddress);
        _state.fetchWHOISInformation(context, widget.ipAddress);
        setState(() => _initialLoad = true);
        await Future.wait([
            _state.geolocationInformation[widget.ipAddress],
            _state.whoisInformation[widget.ipAddress],
        ]);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _initialLoad ? _body : LSLoader(),
    );

    Widget get _appBar => LSAppBar(title: 'IP Address Details');

    Widget get _body => FutureBuilder(
        future: Future.wait([
            Provider.of<TautulliLocalState>(context).geolocationInformation[widget.ipAddress],
            Provider.of<TautulliLocalState>(context).whoisInformation[widget.ipAddress],
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if(snapshot.hasError) {
                if(snapshot.connectionState != ConnectionState.waiting) {
                    Logger.error(
                        '_TautulliIPAddressRoute',
                        '_body',
                        'Unable to fetch Tautulli IP address information',
                        snapshot.error,
                        null,
                        uploadToSentry: !(snapshot.error is DioError),
                    );
                }
                return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
            }
            if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);          
            return LSLoader(); 
        },
    );

    Widget _list(TautulliGeolocationInfo geolocation, TautulliWHOISInfo whois) => LSListView(
        children: [
            LSHeader(text: 'Location Details'),
            TautulliIPAddressDetailsGeolocationTile(geolocation: geolocation),
            LSHeader(text: 'Connection Details'),
            TautulliIPAddressDetailsWHOISTile(whois: whois),
        ],
    );
}

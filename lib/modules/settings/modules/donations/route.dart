import 'dart:async';
import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsDonationsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/donations';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsDonationsRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsDonationsRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsDonationsRoute> createState() => _State();
}

class _State extends State<SettingsDonationsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    static StreamSubscription<List<PurchaseDetails>> purchaseStream;

    @override
    void initState() {
        super.initState();
        purchaseStream = LunaInAppPurchases.connection.purchaseUpdatedStream.listen(_purchasedCallback);
    }

    @override
    void dispose() {
        purchaseStream?.cancel();
        super.dispose();
    }

    Future<void> _purchasedCallback(List<PurchaseDetails> purchases) async {
        for(var purchase in purchases) {
            if(purchase.pendingCompletePurchase) {
                switch(purchase.status) {
                    case PurchaseStatus.error: _purchaseFailed(); break;
                    case PurchaseStatus.purchased: _purchasedSuccess(); break;
                    default: break;
                }
            }
        }
    }

    void _purchasedSuccess() => SettingsRouter.router.navigateTo(context, SettingsDonationsThankYouRoute.route());

    void _purchaseFailed() => LSSnackBar(
        context: context,
        title: 'Transaction Failure',
        message: 'The transaction has failed, please try again',
        type: SNACKBAR_TYPE.failure,
    );

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Donations');

    Widget get _body => LunaInAppPurchases.available && LunaInAppPurchases.products.length != 0
        ? LSListViewBuilder(
            itemCount: LunaInAppPurchases.products.length,
            itemBuilder: (context, index) => SettingsDonationsIAPTile(product: LunaInAppPurchases.products[index]),
        )
        : LSGenericMessage(text: 'In-App Purchases Unavailable');
}

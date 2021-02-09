import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditRouter extends LunaPageRouter {
    RadarrMoviesEditRouter() : super('/radarr/movies/edit/:movieid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int movieId }) async => LunaRouter.router.navigateTo(context, route(movieId: movieId));

    @override
    String route({ @required int movieId }) => fullRoute.replaceFirst(':movieid', movieId.toString());

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrMoviesEditRoute(movieId: int.tryParse(params['movieid'][0]) ?? -1)),
        transitionType: LunaRouter.transitionType,
    );
}

class _RadarrMoviesEditRoute extends StatefulWidget {
    final int movieId;

    _RadarrMoviesEditRoute({
        Key key,
        @required this.movieId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _loaded = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _loaded ? _body : LSLoader(),
    );

    Future<void> _refresh() async {
        context.read<RadarrState>().fetchTags();
        context.read<RadarrState>().fetchQualityProfiles();
        setState(() => _loaded = true);
    }

    Widget get _appBar => LunaAppBar(title: 'Edit Movie');

    Widget get _body => FutureBuilder(
        future: Future.wait([
            context.watch<RadarrState>().movies,
            context.watch<RadarrState>().qualityProfiles,
            context.watch<RadarrState>().tags,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
            if(snapshot.hasData) {
                RadarrMovie movie = (snapshot.data[0] as List<RadarrMovie>).firstWhere(
                    (movie) => movie?.id == widget.movieId,
                    orElse: () => null,
                );
                if(movie != null) return _editList(
                    movie: movie,
                    qualityProfiles: snapshot.data[1],
                    tags: snapshot.data[2],
                );
                return _unknownMovie();
            }
            return LSLoader();
        },
    );

    Widget _editList({
        @required RadarrMovie movie,
        @required List<RadarrQualityProfile> qualityProfiles,
        @required List<RadarrTag> tags,
    }) => ChangeNotifierProvider(
        create: (_) => RadarrMoviesEditState(
            movie: movie,
            qualityProfiles: qualityProfiles ?? [],
            tags: tags ?? [],
        ),
        builder: (context, _) {
            if(context.watch<RadarrMoviesEditState>().state == LunaLoadingState.ERROR)
                return LSGenericMessage(text: 'An Error Has Occurred');
            return LunaListView(
                children: [
                    RadarrMoviesEditMonitoredTile(),
                    RadarrMoviesEditMinimumAvailabilityTile(),
                    RadarrMoviesEditQualityProfileTile(profiles: qualityProfiles),
                    RadarrMoviesEditPathTile(),
                    RadarrMoviesEditTagsTile(),
                    RadarrMoviesEditUpdateMovieButton(movie: movie),
                ],
            );
        }
    );

    Widget _unknownMovie() => LSGenericMessage(text: 'Movie Not Found');
}
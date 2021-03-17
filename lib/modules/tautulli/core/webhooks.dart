import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async {
        _EventType event = _EventType.PLAYBACK_PAUSE.fromKey(data['event']);
        if(event == null) LunaLogger().warning(
            'TautulliWebhooks',
            'handle',
            'Unknown event type: ${data['event'] ?? 'null'}',
        );
        event?.execute(data);
    }
}

enum _EventType {
    PLAYBACK_ERROR,
    PLAYBACK_PAUSE,
    PLAYBACK_RESUME,
    PLAYBACK_START,
    PLAYBACK_STOP,
}

extension _EventTypeExtension on _EventType {
    _EventType fromKey(String key) {
        switch(key) {
            case 'PlaybackError': return _EventType.PLAYBACK_ERROR;
            case 'PlaybackPause': return _EventType.PLAYBACK_PAUSE;
            case 'PlaybackResume': return _EventType.PLAYBACK_RESUME;
            case 'PlaybackStart': return _EventType.PLAYBACK_START;
            case 'PlaybackStop': return _EventType.PLAYBACK_STOP;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        switch(this) {
            case _EventType.PLAYBACK_ERROR: return _playbackErrorEvent(data);
            case _EventType.PLAYBACK_PAUSE: return _playbackPauseEvent(data);
            case _EventType.PLAYBACK_RESUME: return _playbackResumeEvent(data);
            case _EventType.PLAYBACK_START: return _playbackStartEvent(data);
            case _EventType.PLAYBACK_STOP: return _playbackStopEvent(data);
        }
    }

    Future<void> _playbackErrorEvent(Map<dynamic, dynamic> data) async {
        int userId = int.tryParse(data['user_id']);
        if(userId != null) return TautulliUserDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            userId: userId,
        );
    }

    Future<void> _playbackPauseEvent(Map<dynamic, dynamic> data) async {
        String sessionId = data['session_id'];
        if(sessionId != null) return TautulliActivityDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            sessionId: sessionId,
        );
    }

    Future<void> _playbackResumeEvent(Map<dynamic, dynamic> data) async {
        String sessionId = data['session_id'];
        if(sessionId != null) return TautulliActivityDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            sessionId: sessionId,
        );
    }

    Future<void> _playbackStartEvent(Map<dynamic, dynamic> data) async {
        String sessionId = data['session_id'];
        if(sessionId != null) return TautulliActivityDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            sessionId: sessionId,
        );
    }

    Future<void> _playbackStopEvent(Map<dynamic, dynamic> data) async {
        int userId = int.tryParse(data['user_id']);
        if(userId != null) return TautulliUserDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            userId: userId,
        );
    }
}
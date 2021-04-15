import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrHistoryRecord on RadarrHistoryRecord {
    String get lunaFileDeletedReasonMessage {
        if(eventType != RadarrEventType.MOVIE_FILE_DELETED || data['reason'] == null) return LunaUI.TEXT_EMDASH;
        switch(data['reason']) {
            case 'Manual': return 'File was deleted manually';
            case 'MissingFromDisk': return 'Unable to find the file on disk';
            case 'Upgrade': return 'File was deleted to import an upgrade';
            default: return LunaUI.TEXT_EMDASH;
        }
    }
}

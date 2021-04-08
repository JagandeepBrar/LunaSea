import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrQueueRecord on RadarrQueueRecord {
    String get lunaQuality {
        return this.quality?.quality?.name ?? LunaUI.TEXT_EMDASH;
    }

    String get lunaLanguage {
        if((this?.languages?.length ?? 0) == 0) return LunaUI.TEXT_EMDASH;
        if(this.languages.length == 1) return this.languages[0].name ?? LunaUI.TEXT_EMDASH;
        return 'Multi-Language';
    }

    Color get lunaProtocolColor {
        if(this.protocol == RadarrProtocol.USENET) return LunaColours.accent;
        return LunaColours.blue;
    }

    int get lunaPercentageComplete {
        if(this.sizeLeft == null || this.size == null || this.size == 0) return 0;
        double sizeFetched = this.size - this.sizeLeft;
        return ((sizeFetched/this.size)*100).round();
    }

    IconData get lunaStatusIcon {
        switch(this.status) {
            case RadarrQueueRecordStatus.DELAY: return Icons.access_time_rounded;
            case RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE: return Icons.access_time_rounded;
            case RadarrQueueRecordStatus.FAILED: return Icons.cloud_download_rounded;
            case RadarrQueueRecordStatus.PAUSED: return Icons.pause_rounded;
            case RadarrQueueRecordStatus.QUEUED: return Icons.cloud_rounded;
            case RadarrQueueRecordStatus.WARNING: return Icons.cloud_download_rounded;
            case RadarrQueueRecordStatus.COMPLETED: return Icons.download_done_rounded;
            case RadarrQueueRecordStatus.DOWNLOADING: return Icons.cloud_download_rounded;
            default: return Icons.cloud_download_rounded;
        }
    }

    Color get lunaStatusColor {
        // TODO
        return Colors.white;
    }
}
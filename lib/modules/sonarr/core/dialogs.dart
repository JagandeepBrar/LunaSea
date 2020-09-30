import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDialogs {
    SonarrDialogs._();

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        bool _flag = false;
        SonarrGlobalSettingsType _value;
        
        void _setValues(bool flag, SonarrGlobalSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Sonarr Settings',
            content: List.generate(
                SonarrGlobalSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrGlobalSettingsType.values[index].name,
                    icon: SonarrGlobalSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrGlobalSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> seriesSettings(BuildContext context, String title) async {
        bool _flag = false;
        SonarrSeriesSettingsType _value;
        
        void _setValues(bool flag, SonarrSeriesSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: title,
            content: List.generate(
                SonarrSeriesSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrSeriesSettingsType.values[index].name,
                    icon: SonarrSeriesSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrSeriesSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> setDefaultPage(BuildContext context, {
        @required List<String> titles,
        @required List<IconData> icons,
    }) async {
        bool _flag = false;
        int _index = 0;

        void _setValues(bool flag, int index) {
            _flag = flag;
            _index = index;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Default Page',
            content: List.generate(
                titles.length,
                (index) => LSDialog.tile(
                    text: titles[index],
                    icon: icons[index],
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        
        return [_flag, _index];
    }

    static Future<List<dynamic>> searchAllMissingEpisodes(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Missing Episodes',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing episodes?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> editLanguageProfiles(BuildContext context, List<SonarrLanguageProfile> profiles) async {
        bool _flag = false;
        SonarrLanguageProfile profile;

        void _setValues(bool flag, SonarrLanguageProfile value) {
            _flag = flag;
            profile = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Language Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    text: profiles[index].name,
                    icon: Icons.portrait,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, profile];
    }

    static Future<List<dynamic>> editQualityProfile(BuildContext context, List<SonarrQualityProfile> profiles) async {
        bool _flag = false;
        SonarrQualityProfile profile;

        void _setValues(bool flag, SonarrQualityProfile value) {
            _flag = flag;
            profile = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Quality Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    text: profiles[index].name,
                    icon: Icons.portrait,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, profile];
    }

    static Future<List<dynamic>> editRootFolder(BuildContext context, List<SonarrRootFolder> folders) async {
        bool _flag = false;
        SonarrRootFolder _folder;

        void _setValues(bool flag, SonarrRootFolder value) {
            _flag = flag;
            _folder = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Root Folder',
            content: List.generate(
                folders.length,
                (index) => LSDialog.tile(
                    text: folders[index].path,
                    subtitle: LSDialog.richText(
                        children: [
                            LSDialog.bolded(text: folders[index].freeSpace.lsBytes_BytesToString())
                        ],
                    ),
                    icon: Icons.folder,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, folders[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _folder];
    }

    static Future<List<dynamic>> editMonitorStatus(BuildContext context) async {
        bool _flag = false;
        SonarrMonitorStatus _status;

        void _setValues(bool flag, SonarrMonitorStatus status) {
            _flag = flag;
            _status = status;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Monitor Status',
            content: List.generate(
                SonarrMonitorStatus.values.length,
                (index) => LSDialog.tile(
                    text: SonarrMonitorStatus.values[index].name,
                    icon: Icons.view_list,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrMonitorStatus.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _status];
    }

    static Future<List<dynamic>> editSeriesType(BuildContext context) async {
        bool _flag = false;
        SonarrSeriesType _type;

        void _setValues(bool flag, SonarrSeriesType type) {
            _flag = flag;
            _type = type;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Series Type',
            content: List.generate(
                SonarrSeriesType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrSeriesType.values[index].value.lsLanguage_Capitalize(),
                    icon: Icons.folder_open,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrSeriesType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _type];
    }

    /// OLD
    
    static Future<List<dynamic>> downloadWarning(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        
        await LSDialog.dialog(
            context: context,
            title: 'Download Release',
            buttons: [
                LSDialog.button(
                    text: 'Download',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to download this release? It has been marked as a rejected release by Sonarr.')
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteSeries(BuildContext context) async {
        bool _flag = false;
        bool _files = false;

        void _setValues(bool flag, bool files) {
            _flag = flag;
            _files = files;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Remove Series',
            buttons: [
                LSDialog.button(
                    text: 'Remove + Files',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true, true),
                ),
                LSDialog.button(
                    text: 'Remove',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true, false),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to remove the series from Sonarr?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag, _files];
    }

    static Future<List<dynamic>> editEpisode(BuildContext context, String title, bool monitored, bool canDelete) async {
        List<List<dynamic>> _options = [
            monitored
                ? ['Unmonitor Episode', Icons.turned_in_not, 'monitor_status']
                : ['Monitor Episode', Icons.turned_in, 'monitor_status'],
            ['Automatic Search', Icons.search, 'search_automatic'],
            ['Interactive Search', Icons.youtube_searched_for, 'search_manual'],
            if(canDelete) ['Delete File', Icons.delete, 'delete_file'],
        ];
        bool _flag = false;
        String _value = '';

        void _setValues(bool flag, String value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: title,
            content: List.generate(
                _options.length,
                (index) => LSDialog.tile(
                    text: _options[index][0],
                    icon: _options[index][1],
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, _options[index][2]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> searchEntireSeason(BuildContext context, int seasonNumber) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Episode Search',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(
                    text: seasonNumber == 0
                        ? 'Search for all episodes in specials?'
                        : 'Search for all episodes in season $seasonNumber?',
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteEpisodeFile(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Episode File',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this episode file?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }
}

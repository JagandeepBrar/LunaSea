import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';

class NZBGetDialogs {
    NZBGetDialogs._();

    static Future<List<dynamic>> showSettingsPrompt(BuildContext context) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        'NZBGet Settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                ListTile(
                                    leading: Icon(
                                        Icons.language,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        'View Web GUI',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'web_gui';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.add,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Add NZB',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'add_nzb';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.sort,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Sort Queue',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'sort';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.clear_all,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Clear History',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'clear_history';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.settings_power,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'On Complete Action',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'complete_action';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.info_outline,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        'Status & Statistics',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'server_details';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ],
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, value];
    }

    static Future<List<dynamic>> showQueueSettingsPrompt(BuildContext context, String title, bool isPaused) async {
        bool flag = false;
        String value = '';
        await showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                ListTile(
                                    leading: Icon(
                                        isPaused ? Icons.play_arrow : Icons.pause,
                                        color: Colors.blue,
                                    ),
                                    title: Text(
                                        isPaused ? 'Resume Job' : 'Pause Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'status';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.category,
                                        color: Color(Constants.ACCENT_COLOR),
                                    ),
                                    title: Text(
                                        'Change Category',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'category';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.low_priority,
                                        color: Colors.orange,
                                    ),
                                    title: Text(
                                        'Change Priority',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'priority';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.vpn_key,
                                        color: Colors.red,
                                    ),
                                    title: Text(
                                        'Set Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'password';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.text_format,
                                        color: Colors.deepPurpleAccent,
                                    ),
                                    title: Text(
                                        'Rename Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'rename';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                                ListTile(
                                    leading: Icon(
                                        Icons.delete,
                                        color: Colors.blueGrey,
                                    ),
                                    title: Text(
                                        'Delete Job',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    onTap: () {
                                        value = 'delete';
                                        flag = true;
                                        Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                                ),
                            ],
                        ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                );
            },
        );
        return [flag, value];
    }
}
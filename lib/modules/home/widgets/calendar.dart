import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
    final Map<DateTime, List> events;
    final DateTime today;

    CalendarWidget({
        Key key,
        @required this.events,
        @required this.today,
    }) : super(key: key);

    @override
    State<CalendarWidget> createState() => _State();
}

class _State extends State<CalendarWidget> with TickerProviderStateMixin {
    final TextStyle dayTileStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
    final TextStyle outsideDayTileStyle = TextStyle(color: Colors.white30, fontWeight: FontWeight.w600);
    
    List _selectedEvents;
    AnimationController _animationController;
    CalendarController _calendarController;
    
    @override
    void initState() {
        super.initState();
        _selectedEvents = widget.events[widget.today] ?? [];
        _calendarController = CalendarController();
        _animationController = AnimationController( vsync: this, duration: kThemeAnimationDuration);
        _animationController?.forward();
    }

    @override
    void dispose() {
        _animationController.dispose();
        _calendarController.dispose();
        super.dispose();
    }

    void _onDaySelected(DateTime day, List events) {
        setState(() {
            _selectedEvents = events;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Padding(
                child: Column(
                    children: <Widget>[
                        _calendar,
                        LSDivider(),
                        _list,
                    ],
                ),
                padding: EdgeInsets.only(top: 8.0),
            ),
        );
    }

    Widget get _calendar => LSCard(
        child: Padding(
            child: TableCalendar(
                calendarController: _calendarController,
                events: widget.events,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                    selectedColor: LSColors.accent.withOpacity(0.25),
                    markersMaxAmount: 1,
                    markersColor: LSColors.accent,
                    weekendStyle: dayTileStyle,
                    weekdayStyle: dayTileStyle,
                    outsideStyle: outsideDayTileStyle,
                    selectedStyle: dayTileStyle,
                    outsideWeekendStyle: outsideDayTileStyle,
                    renderDaysOfWeek: true,
                    highlightToday: true,
                    todayColor: LSColors.primary,
                    todayStyle: dayTileStyle,
                    outsideDaysVisible: false,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                        color: LSColors.accent,
                        fontWeight: FontWeight.bold,
                    ),
                    weekdayStyle: TextStyle(
                        color: LSColors.accent,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                    ),
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Elements.getIcon(Icons.arrow_back_ios),
                    rightChevronIcon: Elements.getIcon(Icons.arrow_forward_ios),
                ),
                initialCalendarFormat: CalendarFormat.week,
                availableCalendarFormats: const {
                    CalendarFormat.month : 'Month', CalendarFormat.twoWeeks : '2 Weeks', CalendarFormat.week : 'Week'},
                onDaySelected: _onDaySelected,
            ),
            padding: EdgeInsets.only(bottom: 12.0),
        ),
    );

    Widget get _list => Expanded(
        child: LSListView(
            children: _selectedEvents.length == 0 
                ? [LSGenericMessage(text: 'No New Content')]
                : _selectedEvents.map((event) => _entry(event)).toList(),
        ),
    );

    Widget _entry(dynamic event) => LSCardTile(
        title: LSTitle(text: event.title),
        subtitle: RichText(
            text: event.subtitle,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 2,
        ),
        trailing: event.trailing,
        onTap: () async => event.enterContent(context),
        padContent: true,
        decoration: LSCardBackground(uri: event.bannerURI),
    );
}

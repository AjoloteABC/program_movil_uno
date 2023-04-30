import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:program_movil_uno/picker_date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';



class MyCalendar extends StatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  initState() {
    super.initState();
    _loadMeeting();

  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _loadMeeting() async{
    List<Meeting> meetings = <Meeting>[];
    final snapshot = await FirebaseFirestore.instance.collection('Meetings').get();
    final loadedMeetings = snapshot.docs.map((doc) {
      final data = doc.data();
      final nombre = data['nombre'];
      final inicio = data['inicio'];
      final fin = data['fin'];
      final color = Color(int.parse(data['color']));
      final allDay = data['allDay'];
      return Meeting("nConfer", DateTime(inicio ), DateTime(2023,4,15), const Color(0xFF0F8644), false);
    }).toList();
    setState(() {
      meetings = loadedMeetings;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendario',
        ),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(_getDataSource()),
        showNavigationArrow: true,
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),

        //dataSource: MeetingDataSource
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () => _dialogBuilder(context),
      tooltip: 'Añadir evento',
      child: const Icon(Icons.event_sharp),
    ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conferencia', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class Meeting {
  Meeting(this.nombreEvento, this.desde, this.hasta, this.fondoColor, this.diaComp);

  String nombreEvento;
  DateTime desde;
  DateTime hasta;
  Color fondoColor;
  bool diaComp;
}
Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Añadir evento'),
        content:  Container(
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 30),
          width: 600,
          child: PickerDate(),






        ),

        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}




class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].desde;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].hasta;
  }

  @override
  String getSubject(int index) {
    return appointments![index].nombreEvento;
  }

  @override
  Color getColor(int index) {
    return appointments![index].fondoColor;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].diaComp;
  }



}


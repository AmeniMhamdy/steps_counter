import 'dart:async';
import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityRecognitionApp extends StatefulWidget {
  @override
  _ActivityRecognitionAppState createState() => _ActivityRecognitionAppState();
}

class _ActivityRecognitionAppState extends State<ActivityRecognitionApp> {
  StreamSubscription<ActivityEvent>? activityStreamSubscription;
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition();

  @override
  void initState() {
    super.initState();
    _init();
    //_events.add(ActivityEvent.unknown());
  }

  @override
  void dispose() {
    activityStreamSubscription?.cancel();
    super.dispose();
  }

  void _init() async {
    // Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _startTracking();
      }
    }

    // iOS does not
    else {
      _startTracking();
    }
  }

  void _startTracking() {
    activityStreamSubscription = activityRecognition
        .activityStream(runForegroundService: true)
        .listen(onData, onError: onError);
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent);
    if (activityEvent.type != "STILL") {
      setState(() {
        _events.add(activityEvent);
      });
    }
  }

  void onError(Object error) {
    print('ERROR - $error');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Activity Recognition',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: _events.length,
              reverse: true,
              itemBuilder: (_, int idx) {
                final activity = _events[idx];
                return ListTile(
                  leading: _activityIcon(activity.type),
                  title: Text('${activity.type.toString().split('.').last} '),
                  trailing: Text(activity.timeStamp
                      .toString()
                      .split(' ')
                      .last
                      .split('.')
                      .first),
                );
              }),
        ),
      ),
    );
  }

  Icon _activityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.WALKING:
        return const Icon(Icons.directions_walk);
      case ActivityType.IN_VEHICLE:
        return const Icon(Icons.car_rental);
      case ActivityType.ON_BICYCLE:
        return const Icon(Icons.pedal_bike);
      case ActivityType.ON_FOOT:
        return const Icon(Icons.directions_walk);
      case ActivityType.RUNNING:
        return const Icon(Icons.run_circle);
      case ActivityType.STILL:
        return const Icon(Icons.cancel_outlined);
      case ActivityType.TILTING:
        return const Icon(Icons.redo);
      default:
        return const Icon(Icons.device_unknown);
    }
  }
}

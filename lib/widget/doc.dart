import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'current_location.dart';

class Doctor extends StatelessWidget {
  const Doctor({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Walking tips and advice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Dr Joe !',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.orange,
          ),
          const Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: 35,
          color: Colors.orange,
          icon: Icon(Icons.call),
          onPressed: () async {
            final number = '+216 95000102';
            launch('tel://$number');

            await FlutterPhoneDirectCaller.callNumber(number);
          },
        ),
        IconButton(
          iconSize: 35,
          color: Colors.orange,
          icon: Icon(Icons.share_outlined),
          onPressed: () {
            Share.share(
                "https://play.google.com/store/apps/details?id=com.instructivetech.steps_counter");
          },
        ),
        IconButton(
          iconSize: 35,
          color: Colors.orange,
          icon: Icon(Icons.near_me),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurrebtLo(),
              ),
            );
          },
        ),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Don'
        't feel that you have to take long walks every day '
        'It'
        's better to make walking a part of your everyday routine '
        'If your pace makes you feel a bit out of breath'
        'but you can still hold a conversation '
        'that'
        's ideal. But if that'
        's not manageable for you right now, '
        'any kind of activity is better than nothing!',
        softWrap: true,
        //   style: TextStyle(backgroundColor: Colors.blue),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My health care',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/doctor.png',
              width: 600,
              height: 250,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelaza/models/Trip.dart';
import 'date_view.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;
  NewTripLocationView({Key? key, @required required this.trip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Plan - Location'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter A Location'),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                  controller: _titleController,
                  autofocus: true,
                ),
              ),
              RaisedButton(
                child: Text('Continue'),
                onPressed: () {
                  trip.title = _titleController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTripDateView(trip: trip)),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

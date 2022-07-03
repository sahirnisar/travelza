import 'package:flutter/material.dart';
import 'package:travelaza/models/Trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTripBudgetView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Trip trip;
  NewTripBudgetView({Key? key, @required required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Plan - Budget'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter your Budget'),
              Text("Location ${trip.title}"),
              Text("Start Date ${trip.startDate}"),
              Text("End Date ${trip.endDate}"),
              RaisedButton(
                child: Text('Finish'),
                onPressed: () async {
                  //save data to FB
                  await db.collection("trips").add(trip.toJson());

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ));
  }
}

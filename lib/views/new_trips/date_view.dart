import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travelaza/credentials.dart';
import 'package:travelaza/models/Trip.dart';
import 'package:intl/intl.dart';
import 'budget_view.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;
  NewTripDateView({Key? key, @required required this.trip}) : super(key: key);

  @override
  State<NewTripDateView> createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  // DateTimeRange? _selectedDateRange;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 07, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      setState(() {
        _startDate = result.start;
        _endDate = result.end;
      });
    }
  }

  Image getImage(photoReference) {
    final baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    final maxWidth = "1000";
    final maxHeight = "200";
    final url =
        "$baseUrl?maxwidth=$maxWidth&photoreference=$photoReference&key=$PLACES_API_KEY";
    return Image.network(url, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Create Plan - Date'),
            backgroundColor: Colors.pink,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: getImage(widget.trip.photoReference),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 200.00,
            delegate: SliverChildListDelegate([
              buildSelectedDetails(context, widget.trip),
              buildButtons(),
            ]),
          )
        ],
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     getImage(widget.trip.photoReference),
        //     buildSelectedDetails(context, widget.trip),
        //     Spacer(),
        //     Text("Location ${widget.trip.title}"),
        //     ElevatedButton(
        //       child: Text("Select Dates"),
        //       onPressed: _show,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         Text(
        //             "Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}"),
        //         Text(
        //             "End Date: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}"),
        //       ],
        //     ),
        //     ElevatedButton(
        //       child: Text('Continue'),
        //       onPressed: () {
        //         widget.trip.startDate = _startDate;
        //         widget.trip.endDate = _endDate;
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   NewTripBudgetView(trip: widget.trip)),
        //         );
        //       },
        //     ),
        //     Spacer(),
        //   ],
        // ),
      ),
    ));
  }

  Widget buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: RaisedButton(
            child: Text("Choose Dates"),
            color: Colors.deepPurpleAccent,
            textColor: Colors.white,
            onPressed: _show,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: RaisedButton(
            child: Text('Continue'),
            color: Colors.amberAccent,
            onPressed: () {
              widget.trip.startDate = _startDate;
              widget.trip.endDate = _endDate;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTripBudgetView(
                    trip: widget.trip,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildingSelectedDates() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Start Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('dd-MM').format(_startDate).toString()}",
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_startDate).toString()}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            Container(
                child: Icon(
              Icons.arrow_forward,
              color: Colors.deepOrange,
              size: 45,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("End Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('dd-MM').format(_endDate).toString()}",
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_endDate).toString()}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedDetails(BuildContext context, Trip trip) {
    return Hero(
      tag: "SelectedTrip-${trip.title}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, bottom: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(trip.title,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 25.0)),
                              ),
                            ],
                          ),
                          buildingSelectedDates(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

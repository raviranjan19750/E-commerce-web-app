import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:timelines/timelines.dart';


const kTileHeight = 50.0;

class OrderTracking extends StatelessWidget {

  List<Tracking> tracks;
  String title;

  OrderTracking({this.tracks,this.title});

  
  
  @override
  Widget build(BuildContext context) {
    return _DeliveryProcesses(processes: tracks);
  }
}

class _InnerTimeline extends StatelessWidget {

  String dateFormatter(DateTime date){

    final f = new DateFormat('dd MMM yyyy hh:mm a');

    return f.format(date);

  }
  
  const _InnerTimeline({
    @required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 ;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
            thickness: 1.0,
          ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
            size: 10.0,
            position: 0.5,
          ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
          !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(dateFormatter(date)),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
          isEdgeIndex(index) ? true : null,
          itemCount: 2,
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {

  final List<Tracking> processes;

  const _DeliveryProcesses({Key key, @required this.processes})
      : assert(processes != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(

        padding: const EdgeInsets.all(20.0),

        child: FixedTimeline.tileBuilder(

          theme: TimelineThemeData(

            nodePosition: 0,
            color: Color(0xff989898),

            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),

            connectorTheme: ConnectorThemeData(

              thickness: 2.5,

            ),

          ),

          builder: TimelineTileBuilder.connected(

            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,

            contentsBuilder: (_, index) {

              if (processes.length == 0) return null;

              return Padding(

                padding: EdgeInsets.only(left: 8.0),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Text(
                      processes[index].statusValue,

                      style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    _InnerTimeline(date: processes[index].date),
                  ],
                ),
              );
            },


            indicatorBuilder: (_, index) {

              if (processes[index].date.compareTo(DateTime.now()) <= 0) {

                return DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: processes[index].date.compareTo(DateTime.now()) <= 0 ? Color(0xff66c97f) : null,
            ),
          ),
        ),
      ),
    );
  }
}





import 'package:event_management/controllers/events/current_event_controller.dart';
import 'package:event_management/models/Events/current_event_model.dart';
import 'package:event_management/screens/profile/components/app_drawer.dart';
import 'package:event_management/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/widgets/tables/table_scrollable_widget.dart';
import 'package:event_management/widgets/text/table_header_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CurrentEventScreen extends StatefulWidget {
  const CurrentEventScreen({Key? key}) : super(key: key);

  @override
  State<CurrentEventScreen> createState() => _CurrentEventScreenState();
}

class _CurrentEventScreenState extends State<CurrentEventScreen> {
  final List<CurrentEventModel> currentEvent = [];
  bool isLoaded = false;
  @override
  void initState() {
    CurrentEventController.getCurrentEvents().then((event) {
      for (var element in event) {
        currentEvent.add(element);
      }
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Events"),
      ),
      drawer: const AppDrawer(),
      body: !isLoaded
          ? const AppLoadingWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // display top botton and left right scrollable list of events in table
                        TableScrollableWidget(
                          height: context.height() * 0.8,
                          header: const [
                            DataColumn(
                                label: TableHeaderText(text: "Event Name")),
                            DataColumn(
                                label:
                                    TableHeaderText(text: "Event Description")),
                            DataColumn(
                                label: TableHeaderText(text: "Location")),
                            DataColumn(
                                label: TableHeaderText(text: "Location Area")),
                            DataColumn(label: TableHeaderText(text: "Status")),
                            DataColumn(
                                label: TableHeaderText(text: "Deleted At")),
                            DataColumn(
                                label: TableHeaderText(text: "Start Date")),
                            DataColumn(
                                label: TableHeaderText(text: "End Date")),
                            DataColumn(
                                label: TableHeaderText(text: "Created At")),
                            DataColumn(
                                label: TableHeaderText(text: "Updated At")),
                          ],
                          body: List.generate(
                            currentEvent.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(
                                  currentEvent[index].eventName.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index]
                                      .eventDescription
                                      .toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].location.toString(),
                                )),
                                DataCell(Text(currentEvent[index]
                                    .locationArea
                                    .toString())),
                                DataCell(Text(
                                  currentEvent[index].status.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].deletedAt.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].startDate.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].endDate.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].createdAt.toString(),
                                )),
                                DataCell(Text(
                                  currentEvent[index].updatedAt.toString(),
                                )),
                              ],
                            ),
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

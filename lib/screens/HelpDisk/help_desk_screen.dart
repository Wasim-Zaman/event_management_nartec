import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/common/widgets/tables/table_scrollable_widget.dart';
import 'package:event_management/common/widgets/text/table_header.dart';
import 'package:event_management/controllers/HelpDesk/help_desk_controller.dart';
import 'package:event_management/screens/HelpDisk/create_help_desk_screen.dart';
import 'package:event_management/screens/profile/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Help Desk'),
      ),
      body: FutureBuilder(
        future: HelpDeskController.getHelpDesk(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingWidget();
          }
          if (snapshot.hasError) {
            // retry future
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Something went wrong!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      HelpDeskController.getHelpDesk();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TableScrollableWidget(
                    height: context.height() * 0.7,
                    header: const [
                      DataColumn(label: TableHeaderText(text: "Desk ID")),
                      DataColumn(label: TableHeaderText(text: "First Name")),
                      DataColumn(label: TableHeaderText(text: "Last Name")),
                      DataColumn(label: TableHeaderText(text: "Email")),
                      DataColumn(label: TableHeaderText(text: "Issue")),
                      DataColumn(label: TableHeaderText(text: "Ticket No")),
                    ],
                    body: List.generate(
                      snapshot.data!.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(
                            snapshot.data![index].deskID.toString(),
                          )),
                          DataCell(Text(
                            snapshot.data![index].firstName.toString(),
                          )),
                          DataCell(Text(
                            snapshot.data![index].lastName.toString(),
                          )),
                          DataCell(Text(
                            snapshot.data![index].email.toString(),
                          )),
                          DataCell(Text(
                            snapshot.data![index].issue.toString(),
                          )),
                          DataCell(Text(
                            snapshot.data![index].ticketNo.toString(),
                          )),
                        ],
                      ),
                    ).toList(),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButtonWidget(
                      caption: "Create Help Desk",
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const CreateHelpDeskScreen(),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

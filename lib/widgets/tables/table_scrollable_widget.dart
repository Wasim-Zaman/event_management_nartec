import 'package:flutter/material.dart';

class TableScrollableWidget extends StatelessWidget {
  const TableScrollableWidget({
    Key? key,
    required this.header,
    required this.body,
    this.height,
  }) : super(key: key);
  final List<DataColumn> header;
  final List<DataRow> body;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            dataRowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                }
                return Colors.white;
              },
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            dividerThickness: 2,
            border: const TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              verticalInside: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            columns: header,
            rows: body,
          ),
        ),
      ),
    );
  }
}

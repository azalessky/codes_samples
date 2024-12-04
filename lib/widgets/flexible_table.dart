import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class FlexibleColumn {
  final String title;
  final double width;
  final TextAlign align;
  final Function(int row)? onTap;

  FlexibleColumn({
    required this.title,
    required this.width,
    required this.align,
    this.onTap,
  });
}

class FlexibleTable extends StatelessWidget {
  static const horizontalMargin = 32.0;
  static const columnSpacing = 0.0;

  final int rowCount;
  final List<FlexibleColumn> columns;
  final String Function(int column, int row) textBuilder;

  const FlexibleTable({
    required this.rowCount,
    required this.columns,
    required this.textBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int flexColumnCount = columns.where((e) => e.width == 0).length;
    final flexColumnWidth = (MediaQuery.of(context).size.width -
            columns.map((e) => e.width).sum -
            horizontalMargin * 2) /
        flexColumnCount;

    return SingleChildScrollView(
      child: DataTable(
        dividerThickness: 0.00000000001,
        horizontalMargin: horizontalMargin,
        columnSpacing: columnSpacing,
        columns: List<DataColumn>.generate(
          columns.length,
          (index) => DataColumn(
            label: SizedBox(
              width: columns[index].width > 0 ? columns[index].width : flexColumnWidth,
              child: Text(
                columns[index].title,
                textAlign: columns[index].align,
                maxLines: 2,
              ),
            ),
          ),
        ),
        rows: List<DataRow>.generate(
          rowCount,
          (row) => DataRow(
            cells: List<DataCell>.generate(
              columns.length,
              (column) => DataCell(
                SizedBox(
                  width: columns[column].width > 0 ? columns[column].width : flexColumnWidth,
                  child: Text(
                    textBuilder(column, row),
                    textAlign: columns[column].align,
                    maxLines: 2,
                  ),
                ),
                onTap: columns[column].onTap != null ? () => columns[column].onTap!(row) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

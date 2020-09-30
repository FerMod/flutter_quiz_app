import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/menu/drawer_menu.dart';

class QuestionsDataTable extends StatefulWidget {
  QuestionsDataTable({Key key}) : super(key: key);

  @override
  _DataTableState createState() => _DataTableState();
}

class _DataTableState extends State<QuestionsDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  _DataSource _dataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dataSource ??= _DataSource(context);
  }

  void _sort<T>(Comparable<T> Function(_Row r) getField, int columnIndex, bool ascending) {
    _dataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Tables'),
      ),
      drawer: DrawerMenu(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            header: Text('Header Text'),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (value) => setState(() {
              _rowsPerPage = value;
            }),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn(label: Text('Header A'), onSort: (columnIndex, ascending) => _sort<String>((r) => r.valueA, columnIndex, ascending)),
              DataColumn(label: Text('Header B'), onSort: (columnIndex, ascending) => _sort<String>((r) => r.valueB, columnIndex, ascending)),
              DataColumn(label: Text('Header C'), onSort: (columnIndex, ascending) => _sort<String>((r) => r.valueC, columnIndex, ascending)),
              DataColumn(label: Text('Header D'), numeric: true, onSort: (columnIndex, ascending) => _sort<num>((r) => r.valueD, columnIndex, ascending)),
            ],
            source: _dataSource,
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool isSelected = false;
}

class _DataSource extends DataTableSource {
  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  _DataSource(this.context) {
    _rows = _createRows();
  }

  List<_Row> _createRows() {
    return <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1', 1),
      _Row('Cell A2', 'CellB2', 'CellC2', 2),
      _Row('Cell A3', 'CellB3', 'CellC3', 3),
      _Row('Cell A4', 'CellB4', 'CellC4', 4),
    ];
  }

  void _sort<T>(Comparable<T> Function(_Row r) getField, bool ascending) {
    _rows.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.isSelected,
      /*
      onSelectChanged: (value) {
        if (row.isSelected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.isSelected = value;
          notifyListeners();
        }
      },
      */
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

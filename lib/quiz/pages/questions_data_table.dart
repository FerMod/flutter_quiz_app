import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/data/models.dart';
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
                DataColumn(
                  label: Text('Id'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.id, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Question'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.text, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Difficulty'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.difficulty, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Subject'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.subject, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Rating'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.rating, columnIndex, ascending),
                ),
                // DataColumn(
                //   label: Text('Image'),
                //   //onSort: (columnIndex, ascending) => _sort<String>((q) => q.image, columnIndex, ascending),
                // ),
                DataColumn(
                  label: Text('Correct Answer'),
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.correctAnswer, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Incorrect Answers'),
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.incorrectAnswer, columnIndex, ascending),
                ),
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
        DataCell(Text(row.id.toString())),
        DataCell(Text(row.text)),
        DataCell(Text(row.difficulty.toString())),
        DataCell(Text(row.rating.toString())),
        DataCell(Text(row.subject)),
        // DataCell(Text(row.image)),
        DataCell(Text(row.options.firstWhere((e) => e.correct).value)),
        DataCell(Text(row.options.where((e) => !e.correct).map((e) => e.value).join(', '))),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<Question> _createQuestions() {
    return <Question>[
      Question(
        id: 1,
        text: 'Is this a question?',
        difficulty: 1,
        rating: 10,
        subject: 'Test',
        options: [
          Option(value: 'Yes', correct: true),
          Option(value: 'No'),
        ],
      ),
      Question(
        id: 2,
        text: 'Another question in the quiz.',
        difficulty: 4,
        rating: 7,
        subject: 'Test',
        options: [
          Option(value: 'Maybe', correct: true),
          Option(value: 'Yes'),
          Option(value: 'No'),
        ],
      ),
      Question(
        id: 3,
        text: 'Test question?',
        difficulty: 10,
        rating: 1,
        subject: 'Test',
        options: [
          Option(value: 'It is', correct: true),
          Option(value: 'Maybe'),
          Option(value: 'Always'),
          Option(value: 'It isn\'t'),
        ],
      ),
    ];
  }
  
}

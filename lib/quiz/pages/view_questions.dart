import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quiz_app/data/models.dart';
import 'package:flutter_quiz_app/menu/drawer_menu.dart';

// Example code:
// https://github.com/flutter/gallery/blob/master/lib/demos/material/data_table_demo.dart

class QuestionList extends StatefulWidget {
  QuestionList({Key key}) : super(key: key);

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  _QuestionsDataSource _questionsDataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _questionsDataSource ??= _QuestionsDataSource(context);
  }

  void _sort<T>(Comparable<T> Function(Question q) getField, int columnIndex, bool ascending) {
    _questionsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Text"),
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PaginatedDataTable(
              header: Text('Table Header'),
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
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.text, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Difficulty'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.difficulty, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Rating'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.rating, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Subject'),
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.subject, columnIndex, ascending),
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
              source: _questionsDataSource,
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class _QuestionsDataSource extends DataTableSource {
  final BuildContext context;
  List<Question> _questions;

  _QuestionsDataSource(this.context) {
    _questions = _createQuestions();
  }

  void _sort<T>(Comparable<T> Function(Question q) getField, bool ascending) {
    _questions.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _questions.length) return null;

    final question = _questions[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(question.id.toString())),
        DataCell(Text(question.text)),
        DataCell(Text(question.difficulty.toString())),
        DataCell(Text(question.rating.toString())),
        DataCell(Text(question.subject)),
        // DataCell(Text(question.image)),
        DataCell(Text(question.options.firstWhere((e) => e.correct).value)),
        DataCell(Text(question.options.where((e) => !e.correct).map((e) => e.value).join(', '))),
      ],
    );
  }

  @override
  int get rowCount => _questions.length;

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

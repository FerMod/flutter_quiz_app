import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quiz_app/data/question.dart';

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
                  label: Text('email'),
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.email, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('statement'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.statement, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('correctAnswer'),
                  numeric: true,
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.correctAnswer, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('incorrectAnswer'),
                  numeric: true,
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.incorrectAnswer, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('complexity'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.complexity, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('subject'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<String>((q) => q.subject, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('img'),
                  numeric: true,
                  //onSort: (columnIndex, ascending) => _sort<String>((q) => q.img, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('rating'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>((q) => q.rating, columnIndex, ascending),
                ),
              ],
              source: _questionsDataSource,
            ),
          ],
        ),
      ),
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
        DataCell(Text(question.email)),
        DataCell(Text(question.statement)),
        DataCell(Text(question.correctAnswer)),
        DataCell(Text("${question.incorrectAnswer[0]}, ${question.incorrectAnswer[1]}, ${question.incorrectAnswer[2]}")),
        DataCell(Text("${question.complexity}")),
        DataCell(Text(question.subject)),
        DataCell(Text(question.img)),
        DataCell(Text("${question.rating}")),
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
        email: "Correo123@ikasle.ehu.eus",
        statement: "Is this a question?",
        correctAnswer: "Yes",
        incorrectAnswer: ["No", "Always no", "Yes when there is not"],
        complexity: 10,
        subject: "Test",
        img: "",
        rating: 9,
      ),
      Question(
        email: "Correo123@ikasle.ehu.eus",
        statement: "Test question?",
        correctAnswer: "It is",
        incorrectAnswer: ["Maybe", "Always", "It isn't"],
        complexity: 2,
        subject: "Test",
        img: "",
        rating: 2,
      ),
    ];
  }
}

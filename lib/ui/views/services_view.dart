import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 6, vsync: this);
    return Column(children: [
      SizedBox(
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Category'),
            Tab(text: 'Services'),
            Tab(text: 'Option'),
            Tab(text: 'Form'),
            Tab(text: 'Hero Form'),
            Tab(text: 'Promo code'),
          ],
        ),
      ),
      Expanded(
        child: SizedBox(
          width: double.maxFinite,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView(children: [_createHeroesDataTable()]),
              ListView(children: [_createHeroesServicesDataTable()]),
              ListView(children: [_createRequestsDataTable()]),
              Tab(text: 'Form'),
              Tab(text: 'Hero Form'),
              Tab(text: 'Promo code'),
            ],
          ),
        ),
      )
    ]);
  }

  DataTable _createRequestsDataTable() {
    return DataTable(
        columns: _createRequestsColumns(), rows: _createRequestsRows());
  }

  List<DataColumn> _createRequestsColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Request')),
      DataColumn(label: Text('Status'))
    ];
  }

  List<DataRow> _createRequestsRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John')),
        DataCell(Text('Pending'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('David John')),
        DataCell(Text('Pending'))
      ])
    ];
  }

  DataTable _createHeroesDataTable() {
    return DataTable(
        columns: _createHeroesColumns(), rows: _createHeroesRows());
  }

  List<DataColumn> _createHeroesColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Status'))
    ];
  }

  List<DataRow> _createHeroesRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }

  DataTable _createHeroesServicesDataTable() {
    return DataTable(
        columns: _createHeroesServicesColumns(),
        rows: _createHeroesServicesRows());
  }

  List<DataColumn> _createHeroesServicesColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Service')),
      DataColumn(label: Text('Status'))
    ];
  }

  List<DataRow> _createHeroesServicesRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }
}

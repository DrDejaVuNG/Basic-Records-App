import 'package:flutter/material.dart';
import 'package:records_app/utils/hive_data_store.dart';
import '../utils/customtile.dart';
import 'entry.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var records = HiveDataStore().boxRecords.values.toList();
    for (var record in records) {
      allRecords.add(record);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
      ),
      body: Container(
        child: _buildContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EntryPage(
                title: 'New Record',
              ),
            ),
          ).then((value) => setState(() {}));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: HiveDataStore().boxRecords.length,
      itemBuilder: (BuildContext context, index) {
        var item = allRecords[index];

        return Dismissible(
          background: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
              SizedBox(width: 8),
              Text(
                'The record was deleted',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          onDismissed: (direction) {},
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text('Delete Record?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        HiveDataStore().deleteRecord(record: item);
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          key: Key(item.id),
          child: RecordList(item),
        );
      },
    );
  }
}

class RecordList extends CustomListTile {
  RecordList(Record item, {Key? key})
      : super(
          key: key,
          leading: item.name[0],
          title: item.name,
          subtitle: item.contact,
          sysName: item.sysName,
          serialNo: item.serialNo,
          sysType: item.sysType,
          selectedGender: item.selectedGender,
          fault: item.fault,
          contact: item.contact,
          engrName: item.engrName,
          createdAt: item.createdAt,
          record: item,
        );
}

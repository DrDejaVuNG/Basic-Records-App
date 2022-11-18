import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/entry.dart';
import 'views/homepage.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox('records');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Record App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Customer Records'),
    );
  }
}



/*class RecordList extends ListTile {
  RecordList(Record item, {Key? key})
      : super(
            key: key,
            title: Text(item.name),
            subtitle: Text(item.contact),
            leading: CircleAvatar(child: Text(item.name[0])));
}*/





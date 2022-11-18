import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:records_app/utils/hive_data_store.dart';

part 'entry.g.dart';

@HiveType(typeId: 0, adapterName: 'RecordAdapter')
class Record {
  Record({
    required this.id,
    required this.name,
    required this.sysName,
    required this.serialNo,
    required this.sysType,
    required this.selectedGender,
    required this.fault,
    required this.contact,
    required this.engrName,
    required this.createdAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String sysName;

  @HiveField(3)
  String serialNo;

  @HiveField(4)
  String sysType;

  @HiveField(5)
  String selectedGender;

  @HiveField(6)
  String fault;

  @HiveField(7)
  String contact;

  @HiveField(8)
  String engrName;

  @HiveField(9)
  String createdAt;
}

List<Record> allRecords = [];

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const EntryForm()),
    );
  }
}

class EntryForm extends StatefulWidget {
  const EntryForm({Key? key}) : super(key: key);

  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _sysName = '';
  String _serialNo = '';
  String _sysType = 'Desktop';
  int _selectedGender = 0;
  String _fault = '';
  int _contact = -1;
  String _engrName = '';
  bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      value: 0,
      child: Text('Male'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 1,
      child: Text('Female'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
        labelText: 'Enter Name',
        hintText: 'Name',
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // constraints: const BoxConstraints(maxHeight: 25),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateSysName(String? value) {
      if (value!.isEmpty) {
        return 'Please enter System Name';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
        labelText: 'Enter System Name',
        hintText: 'System Name',
      ),
      validator: validateSysName,
      onSaved: (value) {
        setState(() {
          _sysName = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Serial Number', labelText: 'Enter Serial Number'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Serial Number';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _serialNo = value.toString();
        });
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Desktop'),
          value: 'Desktop',
          groupValue: _sysType,
          onChanged: (value) {
            setState(() {
              _sysType = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Laptop'),
          value: 'Laptop',
          groupValue: _sysType,
          onChanged: (value) {
            setState(() {
              _sysType = value.toString();
            });
          },
        ),
      ],
    ));

    formWidget.add(
      TextFormField(
          decoration: const InputDecoration(
              hintText: 'Fault', labelText: 'Enter System Fault'),
          validator: (fault) {
            if (fault != null && fault.isEmpty) {
              return 'Enter System Fault';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            setState(() {
              _fault = value.toString();
            });
          }),
    );

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Contact', labelText: 'Enter Contact'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Phone Number';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _contact = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(
      TextFormField(
          decoration: const InputDecoration(
              hintText: 'Engineer Name', labelText: 'Enter Engineer Name'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Engineer Name';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            setState(() {
              _engrName = value.toString();
            });
          }),
    );

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState?.save();

        String id = const Uuid().v1().toString();
        String name = _name;
        String sysName = _sysName;
        String serialNo = _serialNo.toString();
        String sysType = _sysType;
        String selectedGender = 'Male';
        String fault = _fault;
        String contact = '+234$_contact';
        String engrName = _engrName.toString();
        DateTime now = DateTime.now();
        String dateFormat = DateFormat('dd/MM/yyyy').format(now);

        switch (_selectedGender) {
          case 0:
            selectedGender = "Male";
            break;
          case 1:
            selectedGender = "Female";
            break;
        }

        Record record = Record(
          id: id,
          name: name,
          sysName: sysName,
          serialNo: serialNo,
          sysType: sysType,
          selectedGender: selectedGender,
          fault: fault,
          contact: contact,
          engrName: engrName,
          createdAt: dateFormat,
        );

        HiveDataStore().addRecord(record: record);
        allRecords.clear();

        Navigator.pop(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Record Submitted')));
      }
    }

    formWidget.add(ElevatedButton(
        onPressed: onPressedSubmit, child: const Text('Submit')));

    return formWidget;
  }
}

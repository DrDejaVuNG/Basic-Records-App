import 'package:flutter/material.dart';
import '../views/entry.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.sysName,
    required this.serialNo,
    required this.sysType,
    required this.selectedGender,
    required this.fault,
    required this.contact,
    required this.engrName,
    required this.createdAt,
    required this.record,
  }) : super(key: key);

  final String leading;
  final String title;
  final String subtitle;

  final String sysName;
  final String serialNo;
  final String sysType;
  final String selectedGender;
  final String fault;
  final String contact;
  final String engrName;
  final String createdAt;
  final Record record;

  void _recordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('System Name: $sysName'),
              const SizedBox(height: 5),
              Text('Serial Number: $serialNo'),
              const SizedBox(height: 5),
              Text('System Type: $sysType'),
              const SizedBox(height: 5),
              Text('Gender: $selectedGender'),
              const SizedBox(height: 5),
              Text('System Fault: $fault'),
              const SizedBox(height: 5),
              Text('Contact Info: $contact'),
              const SizedBox(height: 5),
              Text('Engineer name: $engrName'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _recordDialog(context),
      child: SizedBox(
        height: 65,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(child: Text(leading)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(createdAt,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

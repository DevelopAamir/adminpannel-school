import 'package:adminpannel/SchoolAdmin/Connector/pdfGenerator.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/AddResult.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Resultcomponent.dart';
import 'package:adminpannel/SchoolAdmin/objects/resultObj.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowResult extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;
  final class_;
  final section;
  ShowResult({Key? key, required this.data, this.class_, this.section})
      : super(key: key);

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  List<Widget> list = [];
  final firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    for (var i = 0; i < widget.data['Marks'].length; i++) {
      var e = widget.data['Marks'][i];
      setState(() {
        list.add(Resultcard(
            index: '${i + 1}',
            data: ResultSubjectObject(
                e['subject'].toString(),
                e['creditHour'].toString(),
                e['theory'].toString(),
                e['practical'].toString(),
                e['final_grade'].toString(),
                e['gpa'].toString())));
      });
    }
    super.initState();
  }

  GlobalKey? key;
  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.black),
                ),
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35,
                            backgroundImage: NetworkImage(
                              Provider.of<SchoolProvider>(context,
                                      listen: false)
                                  .info
                                  .logo,
                            )),
                        SizedBox(
                          width: 200,
                        ),
                        Expanded(
                          child: Text(
                            Provider.of<SchoolProvider>(context, listen: false)
                                .info
                                .name,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Name:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Class:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Roll No:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.data['Info']['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.data['Info']['class'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.data['Info']['rollno'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Section:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.data['Info']['section'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 140,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Result',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Exam:  ${widget.data['Info']['ExamName']} ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Subjects Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Cradit Hour',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Obtained Grade',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Th',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Pr',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Final Grade',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Grade Point',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Column(children: list),
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'GPA : ${widget.data['Info']['gpa']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Grade : ${widget.data['Info']['Grade']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Remarks : ${widget.data['Info']['Remarks']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                          stream: firestore
                              .collection(Provider.of<SchoolProvider>(context,
                                      listen: false)
                                  .info
                                  .name)
                              .doc('Academics')
                              .collection(widget.class_ + widget.section)
                              .doc('Results')
                              .collection(DateTime.now().year.toString())
                              .doc(
                                  widget.data['Info']['ExamName'] + 'Positions')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snap) {
                            List roll = [];
                            if (snap.hasData)
                              for (var i in snap.data!.data()!['Positions']) {
                                roll.add(num.parse(i['gpa']));
                              }
                            roll.sort((b, a) => a.compareTo(b));
                            print(roll.toString());
                            var position = roll.indexOf(
                                    num.parse(widget.data['Info']['gpa'])) +
                                1;
                            return Text('Position : $position');
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Signaturefield(
                              txtss: 'Date',
                              url: widget.data['Info']['date'],
                              image: true,
                            ),
                            Signaturefield(
                              txtss: 'Class Teacher',
                              url: widget.data['Info']['class_teacher'],
                            ),
                            Signaturefield(
                              txtss: 'Stamp',
                              url: widget.data['Info']['stamp'],
                            ),
                            Signaturefield(
                                txtss: 'Principal',
                                url: widget.data['Info']['principal']),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.data['Info']['name'],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Tooltip(
                message: 'Print Result',
                child: OutlinedButton(
                  onPressed: () async {
                    await generatePdf(
                      ResultObj(
                          Provider.of<SchoolProvider>(context, listen: false)
                              .info
                              .logo,
                          Provider.of<SchoolProvider>(context, listen: false)
                              .info
                              .name,
                          {},
                          widget.data['Marks'],
                          {
                            'name': widget.data['Info']['name'],
                            'rollno': widget.data['Info']['rollno'],
                            'class': widget.data['Info']['class'],
                            'section': widget.data['Info']['section'],
                          },
                          Provider.of<SchoolProvider>(context, listen: false)
                                  .info
                                  .address +
                              ', ' +
                              Provider.of<SchoolProvider>(context,
                                      listen: false)
                                  .info
                                  .phoneNumber,
                          widget.data['Info']['ExamName'],
                          widget.data['Info']['gpa'],
                          widget.data['Info']['Remarks'],
                          prncipal: widget.data['Info']['principal'].toString(),
                          exam_coordinator:
                              widget.data['Info']['stamp'].toString(),
                          class_teacher:
                              widget.data['Info']['class_teacher'].toString(),
                          exam_date: widget.data['Info']['date'].toString()),
                      context,
                    );
                  },
                  child: Icon(Icons.print, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: body);
  }
}

class Resultcard2 extends StatelessWidget {
  final index;
  // final ResultSubjectObject data;
  const Resultcard2({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                index,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'data.subject',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' data.creditHour',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      ' data.theory',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '  data.practical',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'data.finalGrade',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'data.gradePoint',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

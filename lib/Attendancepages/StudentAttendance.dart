import 'package:flutter/material.dart';

class Bill extends StatelessWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EN:1',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Satyanarayan sec school',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '2022/05/01',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              BillCard(
                text1: 'SN',
                text2: 'Catogary',
                text3: 'Amount',
              ),
              BillCard(
                text1: '1',
                text2: 'Admission fee',
                text3: '10,000',
              ),
              BillCard(
                text1: 'Sign:-',
                text2: 'acountant',
                text3: 'Total amount: 10,000',
              ),
            ],
          ),
          width: 400,
          height: 500,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffA3A3A3).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const BillCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Expanded(
        flex: 1,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: Text(text1)),
                Expanded(flex: 3, child: Text(text2)),
                Expanded(
                    flex: 2,
                    child: Text(
                      text3,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    )),
              ],
            ),
          ),
          height: 33,
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

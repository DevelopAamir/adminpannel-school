import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('images/gradient0.png'),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, left: 80, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About School',
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Color(0xff004E36)),
                                    ),
                                    Text(
                                      'Education is the most powerful weapon which you can use to change the world.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9BA49E),
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  // image: DecorationImage(
                                  //   fit: BoxFit.fill,
                                  //   image: NetworkImage(
                                  //       'https://content.thriveglobal.com/wp-content/uploads/2018/01/techandsuccess.jpg'),
                                  // ),
                                ),
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                height: 244,
                                width: 379,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'OUR THOUGHTS',
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Color(0xff004E36)),
                                    ),
                                    Text(
                                      'We can save our  valuable time by the help of technology (Internet). Now the tehnology is playing very important role in our life.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      'Making strong communication between students and teacher.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      'We want to change complexityness into easyness.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      'We can take many atvantage from the internet we can make our students more learner and can give them interest in it.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      'We can provide more opertunitie by the help of internet.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'KNOW MORE',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 17,
                        color: Color(0xff4AA393)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Easy, responsive and simple',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff004E36),
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'This is one of the best benificial platform for  learning, Teaching, make money and many more.',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff9BA49E),
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(29),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                radius: 28,
                                child: rive.RiveAnimation.asset(
                                  'images/animate.riv',
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 98, 99, 99)
                                        .withOpacity(0.30),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'School Mission',
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xff004E36),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 100.0,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Imrove school management system and provide more learning and teaching opertunities for every person who deserve by the following opertunities, ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9BA49E),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                            ),
                            Schoolmissioncards(
                              text: 'E-Learning platform',
                              text2:
                                  'Teacher also can earn and more teach student from this platform.',
                              image: Image.asset('images/computer.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Catch your interest',
                              text2:
                                  'Know your interest here and go ahead with your goal..',
                              image: Image.asset('images/cat.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Find your teacher here',
                              text2: 'Learn more from your teacher from home.',
                              image: Image.asset('images/person.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Show your talent',
                              text2:
                                  'Show your talent here science project,drawings, singing, dancing and other activities',
                              image: Image.asset('images/talent.png'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(29),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                radius: 28,
                                child: rive.RiveAnimation.asset(
                                  'images/animate.riv',
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 98, 99, 99)
                                        .withOpacity(0.30),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Accessible from any device and anywhere',
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xff004E36),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 100.0,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'accessible from any device, without any hurdle, given the user has required user access and credentials. School App helps teachers and school staff access information via Mobile phones. ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9BA49E),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                            ),
                            Schoolmissioncards(
                              text: 'E-Learning platform',
                              text2:
                                  'Teacher also can earn and more teach student from this platform.',
                              image: Image.asset('images/computer.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Catch your interest',
                              text2:
                                  'Know your interest here and go ahead with your goal..',
                              image: Image.asset('images/cat.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Find your teacher here',
                              text2: 'Learn more from your teacher from home.',
                              image: Image.asset('images/person.png'),
                            ),
                            Schoolmissioncards(
                              text: 'Show your talent',
                              text2:
                                  'Show your talent here science project,drawings, singing, dancing and other activities',
                              image: Image.asset('images/talent.png'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(29),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('images/bottomgradient.png'),
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contacts',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff4AA393),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Details(
                                  maintxt: '9811006844:9812345678',
                                ),
                                Details(
                                  maintxt: 'school@gmail.com',
                                ),
                                Details(
                                  maintxt: 'Location:Map',
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Social Network',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff4AA393),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.facebook,
                                      size: 25,
                                      color: Color(0xff8C8C8C),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Facebook',
                                      style: TextStyle(
                                        color: Color(0xff535353),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.message_rounded,
                                      size: 25,
                                      color: Color(0xff8C8C8C),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Message',
                                      style: TextStyle(
                                        color: Color(0xff535353),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.telegram_outlined,
                                      size: 25,
                                      color: Color(0xff8C8C8C),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Telegram',
                                      style: TextStyle(
                                        color: Color(0xff535353),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Help?',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff4AA393),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Help center',
                                  style: TextStyle(
                                    // fontSize: 14,
                                    color: Color(0xff5CEE8D),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Support',
                                  style: TextStyle(
                                    // fontSize: 14,
                                    color: Color(0xff5CEE8D),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Terms and condition',
                                  style: TextStyle(
                                    // fontSize: 14,
                                    // fontWeight: FontWeight.w100,
                                    color: Color(0xff5CEE8D),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Quick response',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17,
                                    color: Color(0xff4AA393),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Center(
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Contact Number and address'),
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  width: 288,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Center(
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Institute Name'),
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  width: 288,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'Submite',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  height: 47,
                                  width: 288,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        // stops: [
                                        //   0.9,
                                        //   0.9,
                                        //   0.9,
                                        //   0.9,
                                        // ],
                                        colors: [
                                          Color(0xff04C899),
                                          Color(0xff5709FB),
                                          Color(0xffFE0000),
                                          Color(0xffFA1C94)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.copyright,
                                      size: 25,
                                      color: Color(0xff8C8C8C),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Details(
                                      maintxt: '2022 school Pvt.Ltd',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height: 400,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Schoolmissioncards extends StatelessWidget {
  final image;
  final String text;
  final String text2;
  const Schoolmissioncards({
    Key? key,
    required this.text,
    required this.text2,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.17,
        height: MediaQuery.of(context).size.width * 0.17,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                child: image,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Color(
                    0xffD96220,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                child: Center(
                  child: Text(
                    text2,
                    style: TextStyle(
                      fontSize: 13.33,
                      color: Color(
                        0xff9BA49E,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFEFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0xffDCEDF0).withOpacity(0.50),
              spreadRadius: 10,
              blurRadius: 19,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String maintxt;
  const Details({
    Key? key,
    required this.maintxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        maintxt,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff535353),
        ),
      ),
    );
  }
}

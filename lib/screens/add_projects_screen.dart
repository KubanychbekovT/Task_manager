import 'package:flutter/material.dart';

class AddProjectsScreen extends StatefulWidget {
  const AddProjectsScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectsScreen> createState() => _AddProjectsScreenState();
}

class _AddProjectsScreenState extends State<AddProjectsScreen> {

  late TextEditingController _Titlecontroller;
  late TextEditingController _EndTime;
  DateTime SelectedDate = DateTime.now();
  String Category = "Meeting";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Titlecontroller = new TextEditingController();

  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        // _Datecontroller.text =
        // '${DateFormat('EEE, MMM d, ' 'yy').format(selected)}';
      });
    }
  }



  _SetCategory(String Category) {
    this.setState(() {
      this.Category = Category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(130, 0, 255, 1),appBar: AppBar(backgroundColor:Color.fromRGBO(130, 0, 255, 1),title:Text(
      "Create New Task",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        decoration: TextDecoration.none,
      ),
    ) ,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextFormField(
                controller: _Titlecontroller,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  labelText: "Title",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(40),
              clipBehavior: Clip.antiAlias,
              padding:
              EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                   Radius.circular(30)
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 8,
                      cursorColor: Colors.black26,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: "Description",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                        fillColor: Colors.black26,
                        labelStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(130, 0, 255, 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Create Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


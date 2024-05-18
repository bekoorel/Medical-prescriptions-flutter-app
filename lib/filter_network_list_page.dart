import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'book.dart';
import 'books_api.dart';

import 'printroshet.dart';
import 'search_widget.dart';
import 'package:http/http.dart' as http;

var showselected = 'Your medicine will appear here';
List printlis = [];

class FilterNetworkListPage extends StatefulWidget {
  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Book> books = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
  }
//......................................................

  Future<List<roshh>> getrosh() async {
    http.Response futurepost =
        await http.get(Uri.parse("http://localhost:5050//roshget.php"));
    if (futurepost.statusCode == 200) {
      List data = jsonDecode(futurepost.body);
      printlis = data;
      List<roshh> allusr = [];
      for (var u in data) {
        roshh usarsroll = roshh.fromJson(u);
        allusr.add(usarsroll);
      }
      setState(() {});

      return allusr;
    } else {
      return throw Exception('انقطع الاتصال');
    }
  }

//***************************************** */
  String name = "";
  TextEditingController instrac = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController discripshn = TextEditingController();
  String id = "";

  Future Adddrug() async {
    var url = 'http://localhost:5050//addrosh.php';
    var respons = await http.post(Uri.parse(url), body: {
      'id': id,
      'name': name,
      'instrac': instrac.text,
      'count': count.text,
      'discripshn': discripshn.text,
    });
    if (respons.statusCode == 200) {
      getrosh();
    }
  }

  //************************************* */
  Future deletdrug(deletid) async {
    var url = 'http://localhost:5050/deletrosh.php';
    var resout3 = await http.post(Uri.parse(url), body: {
      'id': deletid.toString(),
    });
    if (resout3.statusCode == 200) {
      setState(() {});
    }
  }

  String alarm = "";

//.......................................................

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Row(children: [
        Expanded(
            child: Container(
          width: 100.0,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return InkWell(
                      onTap: () {
                        print(book.title);
                        showselected = book.title;
                        name = showselected;
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(book.title),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )),
        VerticalDivider(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                alarm,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              Divider(),
              Text(showselected),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 600.0,
                height: 100.0,
                child: TextField(
                  controller: instrac,
                  decoration: InputDecoration(
                      labelText: 'Enter medication instructions',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.calendar_month_outlined,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 100.0,
                    child: TextField(
                      controller: count,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 600.0,
                child: TextField(
                  controller: discripshn,
                  decoration: InputDecoration(
                      labelText: 'A note on medication',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.note_rounded,
                      )),
                ),
              ),
              Divider(),
              ElevatedButton(
                  onPressed: () {
                    if (instrac.value.text.isEmpty ||
                        count.value.text.isEmpty ||
                        name.isEmpty) {
                      alarm = "الرجاءادخال جميع البيانات المطلوبه";
                    } else {
                      alarm = "";
                      Adddrug();
                    }
                  },
                  child: Text('ADD'))
            ],
          ),
        ),
        VerticalDivider(),
        Expanded(
            flex: 1,
            child: FutureBuilder(
              future: getrosh(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.all(20.0),
                    width: 600.0,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                        margin: EdgeInsets.all(10),
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey[100],
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  deletdrug(
                                                      snapshot.data![index].id);
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                )),
                                            Spacer(),
                                            Column(children: [
                                              Text(
                                                "${snapshot.data![index].name}",
                                              ),
                                              Text(
                                                "${snapshot.data![index].instrac}",
                                              ),
                                              Text(
                                                "${snapshot.data![index].count}",
                                              ),
                                              Text(
                                                "${snapshot.data![index].discripshn}",
                                              ),
                                            ]),
                                            Spacer()
                                          ],
                                        ));
                                  }))),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          printroshet("print"))));
                                },
                                child: Text('PRINT')),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            )),
      ]));

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await BooksApi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });
}

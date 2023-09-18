import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Taskscreen extends StatefulWidget {
  const Taskscreen({super.key});

  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  TextEditingController editingController = TextEditingController();
  List<String> list = [];
  List<bool> blist = [];
  List<String> option = [];
  bool value1 = false;

  void storeData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('task', list);
  }

  void storeBoolData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('opt', option);
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    List w = [];
    if (prefs.getStringList('task') != null) {
      list = prefs.getStringList('task') ?? prefs.getStringList('task')!;
      w = prefs.getStringList('opt') ?? prefs.getStringList('opt')!;
    }
    for (int i = 0; i < w.length; i++) {
      if (w[i] == 'no') {
        blist.add(false);
      } else {
        blist.add(true);
      }
    }
    setState(() {});
  }

  void getBooldata() async {
    final prefs = await SharedPreferences.getInstance();
    option = prefs.getStringList('opt') ?? [];
    for (int i = 0; i < option.length; i++) {
      if (option[i] == 'no') {
        blist.add(false);
      } else {
        blist.add(true);
      }
    }
  }

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('task');
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
      getBooldata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("TODO APP"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: const Icon(Icons.chevron_left)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Dialy routines',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(list.length);
                    print(blist.length);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dismissible(
                        key: Key(list[index]), // Unique key for each item
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            // Remove the item from the list
                            list.removeAt(index);
                            blist.removeAt(index);
                            option.removeAt(index);
                            storeData();
                            storeBoolData();
                          });
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          // Show a confirmation dialog when the user tries to delete
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text(
                                    "Are you sure you want to delete this item?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(true), // Confirm
                                    child: Text("Delete"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(false), // Cancel
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              value: blist[index],
                              title: Text(
                                list[index],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  blist[index] = value!;
                                  option[index] = value ? 'yes' : 'no';
                                });
                                storeBoolData();
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                        content: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              hintText: "Enter your work here"),
                          controller: editingController,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              setState(() {
                                editingController.clear();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.red,
                                elevation: 2,
                                backgroundColor: Colors.amber),
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {
                                if (editingController.text.isNotEmpty) {
                                  list.add(editingController.text);
                                  storeData();
                                  blist.add(false);

                                  storeBoolData();
                                  print(list);
                                }

                                editingController.clear();
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ]));
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

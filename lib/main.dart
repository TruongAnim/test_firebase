import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class SV {
  String name;
  int birthyear;
  SV({required this.name, required this.birthyear});

  Map<String, dynamic> toMap() {
    return {"name": name, "birthyear": birthyear};
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var firebase = FirebaseDatabase.instance;
  TextEditingController inputController = TextEditingController();
  String input = "";
  String data = "null";

  @override
  void initState() {
    super.initState();
    realtime();
  }

  void realtime() {
    var myRef = firebase.ref("parent");
    Stream<DatabaseEvent> stream = myRef.onValue;
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot}'); // DataSnapshot
      setState(() {
        data = event.snapshot.value.toString();
      });
    });
  }

  void recreate() {
    var myRef = firebase.ref("parent");
    myRef.set("child").whenComplete(() {
      setState(() {
        data = "child";
      });
    });
  }

  void readOnce() {
    var myRef = firebase.ref("parent");
    myRef.once().then((value) {
      setState(() {
        data = value.snapshot.value.toString();
        print("read database: $data");
      });
    });
  }

  void update() {
    var myRef = firebase.ref("parent");
    myRef.set(input).whenComplete(() {
      setState(() {
        print("update new value $input");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: inputController,
                      onChanged: (value) {
                        input = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        update();
                      },
                      child: const Text("Update"))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  readOnce();
                },
                child: const Text("Read once")),
            const Text(
              'Data',
            ),
            Text(
              data,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: recreate,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

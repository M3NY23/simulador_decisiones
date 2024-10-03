import 'package:flutter/material.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  final List<String> list = <String>[
    'Maximax',
    'Maximin',
    'Minimax',
    'Minimin',
    'Laplace',
    'Hurwics',
    'Savage'
  ];
  final List<String> list2 = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Simulador", style: TextStyle(color: Colors.white)),
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                _getTable(),
                const SizedBox(height: 50),
                _getSelector(context),
                const SizedBox(height: 50),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                             Color.fromARGB(255, 64, 153, 111))),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Resolver",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Row _getSelector(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: list.first,
            isExpanded: true,
            alignment: AlignmentDirectional.bottomEnd,
            isDense: false,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            icon: const Icon(
              Icons.arrow_downward,
              color: Color.fromARGB(255, 64, 153, 111),
            ),
            elevation: 16,
            // menuWidth: 200,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            underline: Container(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              // setState(() {
              //   dropdownValue = value!;
              // });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView _getTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
              ),
              Container(
                height: 70,
                width: 70,
                child: Center(child: Text("A1")),
              ),
              Container(
                height: 70,
                width: 70,
                child: Center(child: Text("A2")),
              ),
              Container(
                height: 70,
                width: 70,
                child: Center(child: Text("A3")),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
                child: Center(child: Text("E1")),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(child: Text("E2")),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
                child: Center(child: Text("E3")),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

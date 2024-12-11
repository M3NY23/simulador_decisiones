import 'package:flutter/material.dart';
import 'package:simulador_decisiones/objects/Matrix.dart';
import 'package:simulador_decisiones/widgets/custom_table.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  late Matrix matrix;
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
  void initState() {
    matrix = Matrix();
    super.initState();
  }

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 40), child: _getTable()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  _getRowsAndColumnControls(context),
                  const SizedBox(height: 20),
                  _getSelector(context),
                  const SizedBox(height: 20),
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
          ],
        ));
  }

  Widget _getRowsAndColumnControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.white,
                    onPressed: () {
                      matrix.removeRow();
                      setState(() {});
                    }),
              ),
              const Text("Fila"),
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      matrix.addRow();
                      setState(() {});
                    }),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.white,
                    onPressed: () {
                      matrix.removeColumn();
                      setState(() {});
                    }),
              ),
              const Text("Columna"),
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      matrix.addColumn();
                      setState(() {});
                    }),
              )
            ],
          )
        ],
      ),
    );
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
            onChanged: (String? value) {},
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

  CustomTable _getTable() {
    return CustomTable(matrix: matrix);
  }
}

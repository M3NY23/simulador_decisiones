import 'package:flutter/material.dart';
import 'package:simulador_decisiones/controllers/vector_controller.dart';
import 'package:simulador_decisiones/logic/decision_models.dart';
import 'package:simulador_decisiones/objects/vector.dart';
import 'package:simulador_decisiones/widgets/add_remove_widget.dart';
import 'package:simulador_decisiones/widgets/custom_table.dart';
import 'package:simulador_decisiones/widgets/custom_table_result.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  late VectorController vectorContoller;
  late String decisionModelSelected;
  late double rangeSelected;
  final List<String> decisionModels = <String>[
    'Maximax',
    'Maximin',
    'Laplace',
    'Hurwics',
    'Savage'
  ];

  @override
  void initState() {
    vectorContoller = VectorController();
    decisionModelSelected = decisionModels.first;
    rangeSelected = 0.5;
    List<List<double>> list = List.empty(growable: true);
    list.addAll([
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
    ]);
    vectorContoller.vector = Vector(matrix: list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: CustomTable(
                    vector: vectorContoller.vector!,
                    function: (int i, int j) async {
                      await _showInputDialog(context, i, j);
                    })),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getRowsAndColumnControls(context),
                      const SizedBox(height: 10),
                      _getSelector(context),
                      const SizedBox(height: 10),
                      if (decisionModelSelected == 'Hurwics') _getSlider(),
                      _getResolveButton()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _getResolveButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(255, 64, 153, 111))),
        onPressed: onResolvePushed,
        child: const Row(
          children: [
            Expanded(
                child: Text(
              "Resolver",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )),
          ],
        ));
  }

  Widget _getSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Text("Porcentaje de optimismo"),
          Slider(
            value: rangeSelected,
            max: 1,
            min: 0,
            divisions: 10,
            label: "${rangeSelected * 100}%",
            onChanged: (value) {
              rangeSelected = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Simulador", style: TextStyle(color: Colors.white)),
      leading: const BackButton(
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _getRowsAndColumnControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          AddRemoveWidget(
            title: "Fila",
            onPressedRemove: () {
              vectorContoller.removeLastRow();
              setState(() {});
            },
            onPressedAdd: () {
              vectorContoller.addRow();
              setState(() {});
            },
          ),
          const SizedBox(height: 30),
          AddRemoveWidget(
            title: "Columna",
            onPressedRemove: () {
              vectorContoller.removeLastColumn();
              setState(() {});
            },
            onPressedAdd: () {
              vectorContoller.addColumn();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _getSelector(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: decisionModelSelected!,
      alignment: AlignmentDirectional.center,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Color.fromARGB(255, 64, 153, 111),
      ),
      onChanged: (String? value) {
        decisionModelSelected = value!;
        setState(() {});
      },
      items: decisionModels.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<void> _showInputDialog(BuildContext context, int row, int col) async {
    final TextEditingController controller = TextEditingController();
    double? value;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              const Text('Ingresar valor'),
              Text(
                  'Valor actual: ${vectorContoller.vector!.matrix![row][col]}'),
            ],
          ),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Ingrese un número'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                value = double.tryParse(controller.text);
                if (value != null) {
                  vectorContoller.vector!.matrix![row][col] = value!;
                  setState(() {});
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSolutionModal(BuildContext context, Vector vector) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Solución $decisionModelSelected"),
          children: [
            CustomTableResult(vector: vector, model: decisionModelSelected)
          ],
        );
      },
    );
  }

  void onResolvePushed() {
    Vector? resultVector;
    List<List<double>> actualVector = vectorContoller.vector!.matrix!;

    if (decisionModelSelected case "Maximax") {
      resultVector = maximax(actualVector);
    } else if (decisionModelSelected case "Maximin") {
      resultVector = maximin(actualVector);
    } else if (decisionModelSelected case "Laplace") {
      resultVector = laplace(actualVector);
    } else if (decisionModelSelected case "Hurwics") {
      resultVector = hurwicz(actualVector, rangeSelected);
    } else if (decisionModelSelected case "Savage") {
      resultVector = savage(actualVector);
    }

    if (resultVector != null) {
      _showSolutionModal(context, resultVector);
    }
  }
}

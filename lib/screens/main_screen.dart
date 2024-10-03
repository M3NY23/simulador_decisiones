import 'package:flutter/material.dart';
import 'package:simulador_decisiones/screens/hurwics_screen.dart';
import 'package:simulador_decisiones/screens/info_screen.dart';
import 'package:simulador_decisiones/screens/laplace_screen.dart';
import 'package:simulador_decisiones/screens/maximax_maximin_screen.dart';
import 'package:simulador_decisiones/screens/savage_screen.dart';
import 'package:simulador_decisiones/screens/simulator_screen.dart';
import 'package:simulador_decisiones/texts/main_screen_texts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _getDrawer(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            backgroundColor: Theme.of(context).primaryColor,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Criterios de toma de decisión',
                  style: TextStyle(color: Colors.white)),
              background: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/fondo_sliver_2.jpg'))),
                  child: Container(
                      color: Theme.of(context).primaryColor.withAlpha(150))),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InfoScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ))
            ],
          ),
          SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Introducción",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(MainScreenTexts.introduccionBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15))
                      ]))),
          SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Elementos de la toma de decisiones",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 20),
                        Text(MainScreenTexts.elementosDecisionBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15))
                      ]))),
          SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Tipos de decisiones",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Decisiones en condiciones de certeza",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        SizedBox(height: 10),
                        Text(MainScreenTexts.certezaBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Decisiones en condiciones de riesgo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        SizedBox(height: 10),
                        Text(MainScreenTexts.riesgoBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Decisiones en condiciones de incertidumbre",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        SizedBox(height: 10),
                        Text(MainScreenTexts.incertidumbreBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15))
                      ])))
        ],
      ),
    );
  }

  Container _getDrawer(BuildContext context) {
    var listTextStyle = const TextStyle(fontSize: 20);

    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  color: Colors.white,
                  style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                ),
                const Text('Explorar',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            title: Text('Simulador', style: listTextStyle),
            leading: const Icon(Icons.calculate, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SimulatorScreen()));
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text('Criterios de Incertidumbre',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Maximax y Maximin', style: listTextStyle),
            leading: const Icon(Icons.book_sharp, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MaximaxMaximinScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: Text('Laplace', style: listTextStyle),
            leading: const Icon(Icons.book_sharp, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LaplaceScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: Text('Hurwics', style: listTextStyle),
            leading: const Icon(Icons.book_sharp, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HurwicsScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: Text('Savage', style: listTextStyle),
            leading: const Icon(Icons.book_sharp, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SavageScreen()));
            },
          ),
        ],
      ),
    );
  }
}

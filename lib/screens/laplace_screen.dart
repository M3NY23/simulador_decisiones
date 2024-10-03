import 'package:flutter/material.dart';
import 'package:simulador_decisiones/texts/maxi_screen_texts.dart';

class LaplaceScreen extends StatelessWidget {
  const LaplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            backgroundColor: Theme.of(context).primaryColor,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Criterio de Laplace',
                  style: TextStyle(color: Colors.white)),
              background: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/fondo_sliver_3.jpg'))),
                  child: Container(
                      color: Theme.of(context).primaryColor.withAlpha(150))),
            ),
            leading: const BackButton(color: Colors.white)
          ),
          SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(MaxiScreenTexts.introduccionBody,
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Criterio Maximax",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        SizedBox(height: 10),
                        Text(MaxiScreenTexts.maximaxBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Criterio Maximin",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        SizedBox(height: 10),
                        Text(MaxiScreenTexts.maximinBody,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(height: 10),
                      ])))
        ],
      ),
    );
  }
}
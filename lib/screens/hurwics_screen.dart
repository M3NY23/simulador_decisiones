import 'package:flutter/material.dart';
import 'package:simulador_decisiones/texts/maxi_screen_texts.dart';
import 'package:simulador_decisiones/widgets/markdown_viewer.dart';

class HurwicsScreen extends StatelessWidget {
  const HurwicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hurwicz", style: TextStyle(color: Colors.white)),
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const MarkdownViewer(assetPath: "assets/markdown/hurwicz.md"));}
}
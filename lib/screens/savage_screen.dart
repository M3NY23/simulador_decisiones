import 'package:flutter/material.dart';
import 'package:simulador_decisiones/widgets/markdown_viewer.dart';

class SavageScreen extends StatelessWidget {
  const SavageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Savage", style: TextStyle(color: Colors.white)),
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const MarkdownViewer(assetPath: "assets/markdown/savage.md"));}
}
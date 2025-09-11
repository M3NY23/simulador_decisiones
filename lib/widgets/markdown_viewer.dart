import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:simulador_decisiones/logic/utils.dart';
import 'package:simulador_decisiones/widgets/latex.dart';

class MarkdownViewer extends StatefulWidget {
  final String assetPath;

  const MarkdownViewer({required this.assetPath, super.key});

  @override
  State<MarkdownViewer> createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  String markdownContent = '';

  @override
  void initState() {
    super.initState();
    loadMarkdownFile(widget.assetPath).then((content) {
      setState(() {
        markdownContent = content;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: markdownContent.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : MarkdownWidget(
                selectable: true,
                config: MarkdownConfig(configs: []),
                data: markdownContent,
                markdownGenerator: MarkdownGenerator(
                  generators: [latexGenerator],
                  inlineSyntaxList: [LatexSyntax()],
                  richTextBuilder: (span) => Text.rich(span),
                ),
              ));
  }
}

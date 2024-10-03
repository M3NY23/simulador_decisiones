import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 120, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage("assets/images/logo_unam.png"),
                          width: 100, height: 100),
                      Image(
                          image: AssetImage("assets/images/logo_fesc.png"),
                          width: 100, height: 100),
                    ],
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Text("UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text("FACULTAD DE ESTUDIOS SUPERIORES", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: Text("CUAUTITLÁN CAMPO 4", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text("Software desarrollado para la materia:", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: Text("ANALISIS Y TOMA DE DECISIONES", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text("Creado por:", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: Text("Fernando Artemio Maldonado Gonzalez", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: Text("Emmanuel Varela Calderón", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text("Para la enseñanza y aprendizaje derivados de la materia.", style: textStyle, textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
                  child: Text("Código fuente:", style: textStyle, textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 40,
            left: 10,
            child: BackButton(color: Colors.white))
        ],
      ),
    );
  }
}

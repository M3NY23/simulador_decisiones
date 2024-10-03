class MaxiScreenTexts {
  static const introduccionBody = "Los criterios Maximax y Maximin son dos estrategias de toma de decisiones utilizadas en situaciones de incertidumbre, donde no se conocen las probabilidades de los resultados";
  static const maximaxBody = '''
El criterio Maximax se enfoca en maximizar el beneficio potencial, sin considerar los riesgos. Se selecciona la opción que ofrece el mayor beneficio posible.
    
Características:

1. Optimismo: Se asume que ocurran los mejores resultados.
2. Riesgo: No se considera el riesgo de pérdida.
3. Beneficio: Se busca el mayor beneficio posible.

Ejemplo:

    Una empresa considera invertir en un proyecto con tres posibles resultados:

    - Pérdida de 100.000
    - Ganancia de 500.000
    - Ganancia de 1.000.000

    Con el criterio Maximax, la empresa seleccionaría el proyecto, ya que ofrece el mayor beneficio posible (1.000.000).
  ''';
  static const maximinBody = '''
El criterio Maximin se enfoca en minimizar las pérdidas potenciales, considerando los riesgos. Se selecciona la opción que ofrece el menor riesgo de pérdida.

Características:

1. Pesimismo: Se asume que ocurran los peores resultados.
2. Riesgo: Se considera el riesgo de pérdida.
3. Seguridad: Se busca la opción más segura.

Ejemplo:

Una empresa considera invertir en un proyecto con tres posibles resultados:

- Pérdida de 100.000
- Ganancia de 500.000
- Ganancia de 1.000.000

Con el criterio Maximin, la empresa seleccionaría la opción que minimiza la pérdida potencial (pérdida de 100.000), ya que es la opción más segura.

''';
}
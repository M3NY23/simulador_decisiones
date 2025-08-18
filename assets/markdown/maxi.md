# Modelos Maximax y Maximin para la toma de decisiones bajo incertidumbre

En situaciones de incertidumbre, donde no se conocen las probabilidades de los diferentes estados de la naturaleza, existen varios criterios para tomar decisiones racionales. Dos de los más utilizados son el **Maximax** y el **Maximin**. Ambos modelos ayudan al decisor a elegir entre alternativas considerando los posibles resultados (pagos o utilidades) de cada opción.

## Modelo Maximax

El criterio Maximax es conocido como el criterio del **optimista**. El decisor que utiliza este modelo busca la alternativa que le pueda proporcionar el mayor beneficio posible, sin considerar los riesgos o las posibles pérdidas.

### Procedimiento Maximax
1. **Construcción de la matriz de pagos:** Se elabora una tabla con las alternativas y los posibles estados de la naturaleza, junto con los pagos asociados.
2. **Identificación del máximo de cada alternativa:** Para cada alternativa, se identifica el pago máximo que podría obtenerse.
3. **Selección de la alternativa con el máximo valor:** Se elige la alternativa cuyo pago máximo sea el mayor entre todas las alternativas.

### Ejemplo Maximax
Supongamos tres proyectos (A, B y C) y cuatro estados de la naturaleza (S1, S2, S3, S4):

|          | S1 | S2 | S3 | S4 |
|----------|----|----|----|----|
| Proyecto A | 10 | 20 | 30 | 40 |
| Proyecto B | 20 | 15 | 25 | 35 |
| Proyecto C | 30 | 10 | 20 | 30 |

- Máximo de A: 40
- Máximo de B: 35
- Máximo de C: 30

La decisión Maximax sería elegir el Proyecto A, pues tiene el mayor pago posible (40).

## Modelo Maximin

El criterio Maximin es conocido como el criterio del **pesimista**. El decisor que utiliza este modelo busca protegerse contra el peor escenario posible, eligiendo la alternativa cuyo peor resultado sea el menos desfavorable.

### Procedimiento Maximin
1. **Construcción de la matriz de pagos:** Se elabora la tabla de alternativas y estados de la naturaleza.
2. **Identificación del mínimo de cada alternativa:** Para cada alternativa, se identifica el pago mínimo que podría obtenerse.
3. **Selección de la alternativa con el máximo entre los mínimos:** Se elige la alternativa cuyo pago mínimo sea el mayor entre todas las alternativas.

### Ejemplo Maximin
Usando la misma matriz:

|          | S1 | S2 | S3 | S4 |
|----------|----|----|----|----|
| Proyecto A | 10 | 20 | 30 | 40 |
| Proyecto B | 20 | 15 | 25 | 35 |
| Proyecto C | 30 | 10 | 20 | 30 |

- Mínimo de A: 10
- Mínimo de B: 15
- Mínimo de C: 10

La decisión Maximin sería elegir el Proyecto B, pues su peor resultado (15) es mejor que el peor resultado de las otras alternativas.

## Comparación entre Maximax y Maximin

- **Maximax:** Busca el mayor beneficio posible, ideal para decisores optimistas y dispuestos a asumir riesgos.
- **Maximin:** Busca minimizar el daño potencial, ideal para decisores conservadores o aversos al riesgo.

## Ventajas y desventajas

**Maximax:**
- Ventaja: Puede llevar a grandes beneficios si el mejor escenario se cumple.
- Desventaja: Ignora los riesgos y puede llevar a pérdidas significativas si el peor escenario ocurre.

**Maximin:**
- Ventaja: Protege contra el peor escenario posible.
- Desventaja: Puede ser demasiado conservador y perder oportunidades de mayor ganancia.

## Conclusión

Ambos modelos son útiles dependiendo del perfil del decisor y el contexto de la decisión. El Maximax favorece la toma de riesgos y la búsqueda de grandes beneficios, mientras que el Maximin prioriza la seguridad y la protección ante la incertidumbre. Es recomendable analizar el entorno y las preferencias personales antes de elegir el criterio más adecuado.

# Modelo de Savage (Minimización del arrepentimiento) para la toma de decisiones bajo incertidumbre

El modelo de Savage, también conocido como criterio de minimización del arrepentimiento, se basa en la idea de reducir al mínimo el posible arrepentimiento que pueda sentir el decisor por no haber elegido la mejor alternativa en cada estado de la naturaleza.

## Supuestos del modelo
- No se conocen las probabilidades de los estados de la naturaleza.
- El decisor busca minimizar el arrepentimiento potencial.

## Procedimiento
1. **Construcción de la matriz de pagos:** Se elabora una tabla con las alternativas y los posibles estados de la naturaleza.
2. **Construcción de la matriz de arrepentimiento:** Para cada estado de la naturaleza, se identifica el mejor pago posible y se calcula el arrepentimiento de cada alternativa como la diferencia entre ese valor y el pago obtenido por la alternativa.
3. **Identificación del máximo arrepentimiento de cada alternativa:** Para cada alternativa, se determina el mayor arrepentimiento posible.
4. **Selección de la alternativa con el menor arrepentimiento máximo:** Se elige la alternativa cuyo máximo arrepentimiento sea el menor entre todas.

## Ejemplo
Supongamos tres proyectos (A, B y C) y cuatro estados de la naturaleza:

|          | S1 | S2 | S3 | S4 |
|----------|----|----|----|----|
| Proyecto A | 10 | 20 | 30 | 40 |
| Proyecto B | 20 | 15 | 25 | 35 |
| Proyecto C | 30 | 10 | 20 | 30 |

1. Mejor pago por estado:
   - S1: 30
   - S2: 20
   - S3: 30
   - S4: 40
2. Matriz de arrepentimiento:
   - Proyecto A: (30-10), (20-20), (30-30), (40-40) = 20, 0, 0, 0
   - Proyecto B: (30-20), (20-15), (30-25), (40-35) = 10, 5, 5, 5
   - Proyecto C: (30-30), (20-10), (30-20), (40-30) = 0, 10, 10, 10
3. Máximo arrepentimiento:
   - Proyecto A: 20
   - Proyecto B: 10
   - Proyecto C: 10

La mejor decisión sería elegir el Proyecto B o C, ya que ambos tienen el menor arrepentimiento máximo (10).

## Ventajas y desventajas
**Ventajas:**
- Considera el posible arrepentimiento, lo que puede ser relevante psicológicamente.
- Útil cuando se busca evitar el peor escenario de arrepentimiento.

**Desventajas:**
- Puede ser más complejo de calcular que otros modelos.
- No maximiza necesariamente el beneficio, sino que minimiza el arrepentimiento.

## Conclusión
El modelo de Savage es útil para decisores que desean evitar el arrepentimiento máximo en la toma de decisiones bajo incertidumbre, priorizando la tranquilidad ante la posibilidad de no haber elegido la mejor alternativa.

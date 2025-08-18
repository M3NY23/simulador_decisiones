# Modelo de Hurwicz para la toma de decisiones bajo incertidumbre

El modelo de Hurwicz es un criterio de decisión que combina el optimismo y el pesimismo en situaciones de incertidumbre, permitiendo al decisor ajustar su actitud ante el riesgo mediante un parámetro llamado coeficiente de optimismo (α).

## Supuestos del modelo
- No se conocen las probabilidades de los estados de la naturaleza.
- El decisor puede ser más o menos optimista según su preferencia.

## Procedimiento
1. **Construcción de la matriz de pagos:** Se elabora una tabla con las alternativas y los posibles estados de la naturaleza.
2. **Identificación de los valores máximo y mínimo de cada alternativa:** Para cada alternativa, se determina el mejor y el peor resultado posible.
3. **Aplicación del coeficiente de optimismo (α):** Se calcula un valor ponderado para cada alternativa:
   
   \[
   H_i = α \times (máximo) + (1 - α) \times (mínimo)
   \]
   Donde α está entre 0 y 1. Si α = 1, el decisor es completamente optimista; si α = 0, es completamente pesimista.
4. **Selección de la mejor alternativa:** Se elige la alternativa con el mayor valor Hurwicz.

## Ejemplo
Supongamos tres proyectos (A, B y C) y cuatro estados de la naturaleza:

|          | S1 | S2 | S3 | S4 |
|----------|----|----|----|----|
| Proyecto A | 10 | 20 | 30 | 40 |
| Proyecto B | 20 | 15 | 25 | 35 |
| Proyecto C | 30 | 10 | 20 | 30 |

Supongamos α = 0.6:
- Proyecto A: 0.6 × 40 + 0.4 × 10 = 24 + 4 = 28
- Proyecto B: 0.6 × 35 + 0.4 × 15 = 21 + 6 = 27
- Proyecto C: 0.6 × 30 + 0.4 × 10 = 18 + 4 = 22

La mejor decisión sería elegir el Proyecto A.

## Ventajas y desventajas
**Ventajas:**
- Permite ajustar el nivel de optimismo del decisor.
- Es flexible y fácil de aplicar.

**Desventajas:**
- La elección de α puede ser subjetiva.
- No considera todos los resultados posibles, solo los extremos.

## Conclusión
El modelo de Hurwicz es útil cuando el decisor desea equilibrar el optimismo y el pesimismo en la toma de decisiones bajo incertidumbre, adaptando el análisis a su actitud personal frente al riesgo.

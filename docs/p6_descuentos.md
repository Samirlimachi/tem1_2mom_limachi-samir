# Pregunta 6. Análisis del impacto de los descuentos

## Enunciado
Analice la relación entre los descuentos comerciales y la rentabilidad. Clasifique los registros en los siguientes rangos:
- Sin descuento: 0.
- Descuento bajo: mayor a 0 y hasta 20%.
- Descuento medio: mayor a 20% y hasta 50%.
- Descuento alto: mayor a 50%.

Calcule: ventas y ganancias por rango, margen de rentabilidad, cantidad de registros con pérdidas, porcentaje de registros no rentables, descuento promedio, y categorías y subcategorías más afectadas.

Finalmente, identifique si los descuentos elevados están asociados con una mayor proporción de operaciones no rentables.

## Estrategia
Agrupé las operaciones por nivel de descuento y comparé dos medidas en cada grupo. El margen indica cuánto se ganó o perdió en relación con las ventas. El porcentaje de operaciones con pérdida muestra con qué frecuencia ocurrió.

## Consulta
`sql/06_descuentos.sql`

## Resultados

### Por rango de descuento

| Rango | Registros | Ventas | Ganancia | Margen % | Con pérdida | % no rentables | Descuento prom. % |
|-------|----------:|-------:|---------:|---------:|------------:|---------------:|------------------:|
| Sin descuento | 4798 | 1087908.47 | 320987.60 | 29.51 | 0 | 0.00 | 0.00 |
| Bajo (0-20%) | 3803 | 846522.24 | 100785.47 | 11.91 | 523 | 13.75 | 19.68 |
| Medio (20-50%) | 537 | 298541.41 | -58817.00 | -19.70 | 492 | 91.62 | 36.70 |
| Alto (>50%) | 856 | 64228.74 | -76559.05 | -119.20 | 856 | 100.00 | 71.89 |

### Subcategorías más afectadas (descuento medio y alto)

| Categoría | Subcategoría | Registros | Descuento prom. % | Ganancia | Con pérdida | % no rentables |
|-----------|--------------|----------:|------------------:|---------:|------------:|---------------:|
| Office Supplies | Binders | 613 | 73.80 | -38510.50 | 613 | 100.00 |
| Furniture | Tables | 176 | 39.29 | -30698.22 | 172 | 97.73 |
| Technology | Machines | 53 | 54.34 | -29555.35 | 44 | 83.02 |
| Furniture | Bookcases | 70 | 44.49 | -11097.76 | 69 | 98.57 |
| Office Supplies | Appliances | 67 | 80.00 | -8629.64 | 67 | 100.00 |
| Furniture | Chairs | 158 | 30.00 | -6737.12 | 148 | 93.67 |
| Technology | Phones | 109 | 40.00 | -6385.79 | 97 | 88.99 |
| Furniture | Furnishings | 138 | 60.00 | -5944.66 | 138 | 100.00 |
| Technology | Copiers | 9 | 40.00 | 2182.98 | 0 | 0.00 |

## Interpretación
Las operaciones sin descuento tuvieron un margen del 29,5 % y ninguna registró pérdidas. Con descuento bajo, el margen bajó al 11,9 % y el 13,8 % de las operaciones terminó en pérdida. En el tramo medio, el margen fue de −19,7 % y el 91,6 % de las operaciones perdió dinero. En el tramo alto, el margen llegó a −119,2 % y todas las operaciones registraron pérdidas. Entre los descuentos medios y altos, la pérdida fue de unos 135 mil.

Entre las subcategorías más afectadas estuvieron Binders, con 38,5 mil de pérdida y un 100 % de operaciones con pérdida en el tramo analizado, Tables con 30,7 mil de pérdida y Machines con 29,6 mil. Copiers mantuvo una ganancia. El resultado de Tables ayuda a entender parte del bajo margen de Furniture en P5. En Central, el margen bajo de P3 da pie a revisar qué descuentos se aplicaron y en qué productos.

## Conclusión
Sí, en estos datos, a medida que aumenta el descuento también aumenta la proporción de operaciones que pierden dinero. Los tramos medio y alto son los primeros que revisaría, empezando por las subcategorías con mayores pérdidas.

## Evidencia
- `evidencias/p6_descuentos.png`

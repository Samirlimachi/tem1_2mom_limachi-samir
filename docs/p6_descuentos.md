# Pregunta 6. Análisis del impacto de los descuentos

## Estrategia


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


## ¿Los descuentos elevados están asociados a más operaciones no rentables?


## Conclusión


## Evidencia
- `evidencias/p6_descuentos.png`

# Pregunta 4. Segmentación de clientes mediante RFM

## Estrategia


## Consulta
`sql/04_rfm.sql`

## Criterios de segmentación

Puntajes de 1 a 5 con `NTILE(5)` (5 = mejor). Fecha de referencia: 2017-12-30.

| Segmento | Regla | Justificación |
|----------|-------|---------------|
| Alto valor | R >= 4, F >= 4, M >= 4 | |
| Recurrente | R >= 3, F >= 4 | |
| En riesgo | R <= 2 y (F >= 3 o M >= 4) | |
| Nuevo | R >= 4, F <= 2 | |
| Perdido | R <= 2, F <= 2 | |
| Potencial | Resto | |

## Resultados

| Segmento | Clientes | Recency prom. | Frequency prom. | Monetary prom. | Ventas total |
|----------|---------:|--------------:|----------------:|---------------:|-------------:|
| En riesgo | 169 | 247.2 | 7.1 | 3701.56 | 625563.40 |
| Alto valor | 105 | 24.8 | 9.3 | 5269.17 | 553262.38 |
| Potencial | 154 | 56.4 | 5.4 | 2892.73 | 445481.01 |
| Recurrente | 129 | 50.0 | 8.5 | 2749.46 | 354680.90 |
| Perdido | 149 | 367.3 | 3.6 | 1078.15 | 160645.01 |
| Nuevo | 87 | 25.1 | 4.1 | 1811.13 | 157568.31 |

Top 5 alto valor: Adrian Barton (14473.57), Ken Lonsdale (14175.23), Sanjit Engle (12209.44), Greg Tran (11820.12), Maria Etezadi (10663.73).

Top 5 en riesgo: Tamara Chand (19052.22, 399 días), Sanjit Chand (14142.33, 349 días), Becky Martin (11789.63, 307 días), Caroline Jumper (11164.97, 189 días), Clay Ludtke (10880.55, 284 días).

## Interpretación


## Conclusión


## Evidencia
- `evidencias/p4_rfm.png`

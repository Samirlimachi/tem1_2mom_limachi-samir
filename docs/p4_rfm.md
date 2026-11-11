# Pregunta 4. Segmentación de clientes mediante RFM

## Enunciado
Construya un análisis RFM (Recency, Frequency, Monetary) para identificar los diferentes perfiles de clientes. Determine:
- Recency: días desde la última compra de cada cliente, tomando como referencia la fecha máxima del dataset.
- Frequency: cantidad de órdenes únicas realizadas.
- Monetary: importe total de ventas acumuladas.
- Clasificación de clientes mediante puntuaciones RFM.
- Identificación de clientes de alto valor, recurrentes y en riesgo de abandono.

Defina y justifique los criterios utilizados para segmentar los clientes.

## Estrategia
Tomé el 30 de diciembre de 2017 como fecha de referencia. Para cada cliente, calculé cuántos días habían pasado desde su última compra, cuántas órdenes había realizado y cuánto había gastado. Luego usé NTILE(5) para asignar un puntaje del 1 al 5 en cada dimensión. En recencia, las compras más cercanas a la fecha de referencia recibieron las puntuaciones más altas.

## Consulta
`sql/04_rfm.sql`

## Criterios de segmentación

Puntajes de 1 a 5 con `NTILE(5)` (5 = mejor). Fecha de referencia: 2017-12-30.

| Segmento | Regla | Justificación |
|----------|-------|---------------|
| Alto valor | R >= 4, F >= 4, M >= 4 | Destacan en las tres dimensiones |
| Recurrente | R >= 3, F >= 4 | Compran seguido y siguen activos |
| En riesgo | R <= 2 y (F >= 3 o M >= 4) | Tenían un buen historial de compras, pero llevan bastante tiempo sin volver |
| Nuevo | R >= 4, F <= 2 | Compraron hace poco y todavía tienen pocas órdenes |
| Perdido | R <= 2, F <= 2 | Combinan poca frecuencia con un largo tiempo de inactividad |
| Potencial | Resto | No cumplen ninguna de las reglas anteriores |

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
Los clientes de alto valor destacan en las tres dimensiones. Los recurrentes compran seguido y siguen activos, mientras que los nuevos compraron hace poco y todavía tienen pocas órdenes. Los clientes en riesgo habían mostrado un buen historial de compras, aunque ya llevan bastante tiempo sin volver. Los perdidos combinan poca frecuencia con un largo tiempo de inactividad. La distribución fue de 169 clientes en riesgo, 105 de alto valor, 129 recurrentes, 87 nuevos, 149 perdidos y 154 potenciales.

El grupo en riesgo fue el que más aportó en ventas, con unos 625 mil, y llevaba en promedio 247 días sin comprar. Tamara Chand ilustra el caso. Había gastado cerca de 19 mil y su última compra fue 399 días antes de la fecha de referencia. El grupo de alto valor generó unos 553 mil. Sus integrantes habían comprado hacía unos 25 días en promedio, con 9,3 órdenes y un gasto promedio de 5.269 por cliente.

## Conclusión
Priorizaría recuperar a los clientes en riesgo. Su historial de compras y el tiempo que llevan inactivos dan un criterio para decidir a quién contactar primero.

## Evidencia
- `evidencias/p4_rfm.png`

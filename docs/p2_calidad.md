# Pregunta 2. Auditoría de calidad e integridad de datos

## Enunciado
Realice un análisis de calidad sobre el dataset. Determine:
- Cantidad total de registros.
- Cantidad de identificadores de fila duplicados.
- Cantidad de órdenes únicas y clientes únicos.
- Campos que contienen valores NULL.
- Registros con fechas inválidas o inconsistentes.
- Registros con ventas iguales o inferiores a cero.
- Registros con descuentos fuera del intervalo esperado.
- Registros donde la fecha de envío sea anterior a la fecha de pedido.

Construya una consulta que permita obtener un resumen de calidad de datos y proponga criterios de tratamiento para las inconsistencias identificadas.

## Estrategia
Primero usé COUNT(DISTINCT) para contar las órdenes y los clientes únicos. Después, con SUM(CASE WHEN ...), pude contar los casos que incumplían cada regla de calidad en una sola consulta.

## Consulta
`sql/02_calidad.sql`

## Resultados

| Indicador | Valor |
|-----------|------:|
| Total de registros | 9994 |
| Row ID duplicados | 0 |
| Órdenes únicas | 5009 |
| Clientes únicos | 793 |
| Fechas inválidas | 0 |
| Ventas <= 0 | 0 |
| Descuentos fuera de 0-1 | 0 |
| Envío antes del pedido | 0 |
| Campos con NULL | 0 (en los 21 campos) |

| Rango | Mínimo | Máximo |
|-------|--------|--------|
| order_date | 2014-01-03 | 2017-12-30 |
| ship_date | 2014-01-07 | 2018-01-05 |
| discount | 0.00 | 0.80 |

## Interpretación
El conjunto tiene 9.994 registros, 5.009 órdenes y 793 clientes. Cada fila corresponde a un producto dentro de una orden. En promedio, hay unas dos líneas de producto por orden y unas seis órdenes por cliente.

Las comprobaciones dieron cero `row_id` duplicados, cero valores nulos en las 21 columnas, cero fechas inválidas, cero ventas iguales o menores que cero, cero descuentos fuera de rango y cero envíos anteriores al pedido. Los pedidos van del 3 de enero de 2014 al 30 de diciembre de 2017. Los envíos que aparecen en enero de 2018 son coherentes con los pedidos de fin de año. Los descuentos observados van del 0 % al 80 %.

## Criterios de tratamiento
Si encontrara duplicados, conservaría una sola copia de cada registro. Si hubiera un valor nulo, lo completaría cuando pudiera recuperarlo de una fuente confiable. En los demás casos, excluiría la fila del análisis que dependa de ese dato. Excluiría las ventas iguales o menores que cero y marcaría como error cualquier descuento superior al 100 %. Si un envío figurara antes de su pedido, reportaría el caso y lo excluiría del cálculo de los tiempos de entrega.

## Conclusión
Con los controles realizados, los datos están listos para el análisis sin necesidad de depuración previa.

## Evidencia
- `evidencias/p2_calidad.png`

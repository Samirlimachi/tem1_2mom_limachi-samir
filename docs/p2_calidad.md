# Pregunta 2. Auditoría de calidad e integridad de datos

## Estrategia


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


## Criterios de tratamiento


## Conclusión


## Evidencia
- `evidencias/p2_calidad.png`

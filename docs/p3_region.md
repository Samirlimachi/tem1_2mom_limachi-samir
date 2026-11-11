# Pregunta 3. Análisis de evolución comercial por región

## Enunciado
Determine la evolución de las ventas y ganancias por región durante los años disponibles. Debe obtener:
- Ventas totales por región y año.
- Ganancia total por región y año.
- Margen de rentabilidad.
- Variación porcentual respecto al año anterior.
- Identificación de la región con mejor y peor desempeño comercial.

Utilice CTE y funciones de ventana para resolver el problema.

## Estrategia
Agrupé las ventas y las ganancias por región y año en una CTE. Usé LAG() con PARTITION BY region para calcular la variación anual de cada región y RANK() para ordenar las regiones por ganancia.

## Consulta
`sql/03_region.sql`

## Resultados

### Por región y año

| Región | Año | Ventas | Ganancia | Margen % | Var. ventas % | Var. ganancia % |
|--------|-----|-------:|---------:|---------:|--------------:|----------------:|
| Central | 2014 | 103838.16 | 539.55 | 0.52 | - | - |
| Central | 2015 | 102874.22 | 11716.80 | 11.39 | -0.93 | 2071.57 |
| Central | 2016 | 147429.38 | 19899.16 | 13.50 | 43.31 | 69.83 |
| Central | 2017 | 147098.13 | 7550.84 | 5.13 | -0.22 | -62.05 |
| East | 2014 | 128680.46 | 17059.61 | 13.26 | - | - |
| East | 2015 | 156332.06 | 21091.01 | 13.49 | 21.49 | 23.63 |
| East | 2016 | 180685.82 | 20141.60 | 11.15 | 15.58 | -4.50 |
| East | 2017 | 213082.90 | 33230.56 | 15.60 | 17.93 | 64.98 |
| South | 2014 | 103845.84 | 11879.12 | 11.44 | - | - |
| South | 2015 | 71359.98 | 8318.59 | 11.66 | -31.28 | -29.97 |
| South | 2016 | 93610.22 | 17702.81 | 18.91 | 31.18 | 112.81 |
| South | 2017 | 122905.86 | 8848.91 | 7.20 | 31.30 | -50.01 |
| West | 2014 | 147883.03 | 20065.69 | 13.57 | - | - |
| West | 2015 | 139966.25 | 20492.19 | 14.64 | -5.35 | 2.13 |
| West | 2016 | 187480.18 | 24051.61 | 12.83 | 33.95 | 17.37 |
| West | 2017 | 250128.37 | 43808.96 | 17.51 | 33.42 | 82.15 |

### Total 2014-2017

| Región | Ventas | Ganancia | Margen % | Ranking |
|--------|-------:|---------:|---------:|--------:|
| West | 725457.82 | 108418.45 | 14.94 | 1 |
| East | 678781.24 | 91522.78 | 13.48 | 2 |
| South | 391721.91 | 46749.43 | 11.93 | 3 |
| Central | 501239.89 | 39706.36 | 7.92 | 4 |

## Interpretación
West quedó primero con 108 mil de ganancia y un margen del 14,94 %. Le siguieron East con 91,5 mil y un margen del 13,48 %, South con 46,7 mil y un 11,93 %, y Central con 39,7 mil y un 7,92 %. West también lideró en ventas. En 2017, sus ventas crecieron un 33 % y su ganancia aumentó un 82 %.

Central vendió 501 mil, frente a los 392 mil de South, y aun así terminó con menos ganancia. En 2014, su margen fue de apenas 0,52 %, por lo que el aumento del 2.071 % debe leerse teniendo en cuenta que partió de una ganancia muy baja. En 2017, la ganancia de Central cayó un 62 %. Ese mismo año, South vendió un 31 % más y su ganancia se redujo a la mitad.

## Conclusión
West tuvo el mejor desempeño porque convirtió su liderazgo en ventas en la mayor ganancia y el mayor margen. Los resultados de Central y South muestran por qué conviene mirar las tres cifras juntas. Una región puede vender más y quedarse con menos ganancia.

## Evidencia
- `evidencias/p3_region.png`

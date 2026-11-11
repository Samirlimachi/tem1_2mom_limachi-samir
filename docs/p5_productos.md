# Pregunta 5. Ranking de productos según rentabilidad

## Estrategia


## Consulta
`sql/05_productos.sql`

## Resultados

### Top 5 por ganancia en cada categoría

| Categoría | RANK | DENSE_RANK | Producto | Ventas | Ganancia | Margen % | Ganancia acumulada |
|-----------|-----:|-----------:|----------|-------:|---------:|---------:|-------------------:|
| Furniture | 1 | 1 | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back | 10637.53 | 1927.44 | 18.12 | 1927.44 |
| Furniture | 2 | 2 | Global Deluxe High-Back Manager's Chair | 8665.19 | 1558.59 | 17.99 | 3486.03 |
| Furniture | 3 | 3 | Hon Pagoda Stacking Chairs | 6483.80 | 1540.70 | 23.76 | 5026.74 |
| Furniture | 4 | 4 | Hon 4070 Series Pagoda Armless Upholstered Stacking Chairs | 8431.00 | 1388.63 | 16.47 | 6415.37 |
| Furniture | 5 | 5 | Office Star - Professional Matrix Back Chair | 8774.50 | 1305.65 | 14.88 | 7721.02 |
| Office Supplies | 1 | 1 | Fellowes PB500 Electric Punch Plastic Comb Binding Machine | 27453.38 | 7753.04 | 28.24 | 7753.04 |
| Office Supplies | 2 | 2 | Ibico EPK-21 Electric Binding System | 15875.92 | 3345.28 | 21.07 | 11098.32 |
| Office Supplies | 3 | 3 | Honeywell Enviracaire Portable HEPA Air Cleaner | 11304.44 | 3247.02 | 28.72 | 14345.34 |
| Office Supplies | 4 | 4 | Fellowes PB300 Plastic Comb Binding Machine | 8070.19 | 2518.06 | 31.20 | 16863.40 |
| Office Supplies | 5 | 5 | Ibico Ibimaster 300 Manual Binding System | 7985.38 | 2318.34 | 29.03 | 19181.73 |
| Technology | 1 | 1 | Canon imageCLASS 2200 Advanced Copier | 61599.82 | 25199.93 | 40.91 | 25199.93 |
| Technology | 2 | 2 | Hewlett Packard LaserJet 3310 Copier | 18839.69 | 6983.88 | 37.07 | 32183.81 |
| Technology | 3 | 3 | Canon PC1060 Personal Laser Copier | 11619.83 | 4570.93 | 39.34 | 36754.75 |
| Technology | 4 | 4 | HP Designjet T520 Inkjet Large Format Printer | 18374.90 | 4094.98 | 22.29 | 40849.72 |
| Technology | 5 | 5 | Ativa V4110MDD Micro-Cut Shredder | 7699.89 | 3772.95 | 49.00 | 44622.67 |

### Top 5 por volumen de ventas

| Rank | Categoría | Producto | Unidades | Ventas | Ganancia | Margen % |
|-----:|-----------|----------|---------:|-------:|---------:|---------:|
| 1 | Technology | Canon imageCLASS 2200 Advanced Copier | 20 | 61599.82 | 25199.93 | 40.91 |
| 2 | Office Supplies | Fellowes PB500 Electric Punch Plastic Comb Binding Machine | 31 | 27453.38 | 7753.04 | 28.24 |
| 3 | Technology | Cisco TelePresence System EX90 Videoconferencing Unit | 6 | 22638.48 | -1811.08 | -8.00 |
| 4 | Furniture | HON 5400 Series Task Chairs for Big and Tall | 39 | 21870.58 | 0.00 | 0.00 |
| 5 | Office Supplies | GBC DocuBind TL300 Electric Binding System | 37 | 19823.48 | 2233.51 | 11.27 |

### 5 productos con menor rentabilidad

| Rank | Categoría | Producto | Ventas | Ganancia | Margen % | Posición en categoría |
|-----:|-----------|----------|-------:|---------:|---------:|----------------------:|
| 1 | Technology | Cubify CubeX 3D Printer Double Head Print | 11099.96 | -8879.97 | -80.00 | 413 |
| 2 | Technology | Lexmark MX611dhe Monochrome Laser Printer | 16829.90 | -4589.97 | -27.27 | 412 |
| 3 | Technology | Cubify CubeX 3D Printer Triple Head Print | 7999.98 | -3839.99 | -48.00 | 411 |
| 4 | Furniture | Chromcraft Bull-Nose Wood Oval Conference Tables & Bases | 9917.64 | -2876.12 | -29.00 | 383 |
| 5 | Furniture | Bush Advantage Collection Racetrack Conference Table | 9544.73 | -1934.40 | -20.27 | 382 |

### Margen por categoría

| Categoría | Productos | Con pérdida | Margen promedio % |
|-----------|----------:|------------:|------------------:|
| Furniture | 383 | 123 | 8.26 |
| Office Supplies | 1098 | 124 | 25.63 |
| Technology | 413 | 57 | 14.44 |

El margen individual y la posición de cada producto están en la tabla `ranking_productos` (1894 productos).

## Interpretación


## Conclusión


## Evidencia
- `evidencias/p5_productos.png`

# Pregunta 8. Análisis Pareto de ventas y rentabilidad

## Enunciado
Aplique la regla 80/20 para identificar la concentración comercial. Realice dos análisis independientes:

a) Determine qué cantidad de productos representa el 80% de las ventas acumuladas.

b) Determine qué cantidad de productos representa el 80% de las ganancias acumuladas.

Para ambos análisis: ordene los productos de mayor a menor contribución, calcule el porcentaje de participación individual, identifique los productos que concentran la mayor contribución económica, y compare ambos resultados y explique las diferencias encontradas.

## Estrategia
Ordené los productos de mayor a menor por ventas y por ganancia, y calculé el porcentaje acumulado en cada ranking. Así pude identificar cuántos productos hacían falta para llegar al 80 % de cada total.

## Consulta
`sql/08_pareto.sql`

## Resultados

### a) Pareto de ventas

| Total productos | Productos que hacen el 80% | % de productos |
|----------------:|---------------------------:|---------------:|
| 1894 | 423 | 22.33 |

Top 10 por contribución a ventas:

| Pos. | Producto | Categoría | Ventas | % individual | % acumulado |
|-----:|----------|-----------|-------:|-------------:|------------:|
| 1 | Canon imageCLASS 2200 Advanced Copier | Technology | 61599.82 | 2.6815 | 2.68 |
| 2 | Fellowes PB500 Electric Punch Plastic Comb Binding Machine | Office Supplies | 27453.38 | 1.1951 | 3.88 |
| 3 | Cisco TelePresence System EX90 Videoconferencing Unit | Technology | 22638.48 | 0.9855 | 4.86 |
| 4 | HON 5400 Series Task Chairs for Big and Tall | Furniture | 21870.58 | 0.9521 | 5.81 |
| 5 | GBC DocuBind TL300 Electric Binding System | Office Supplies | 19823.48 | 0.8629 | 6.68 |
| 6 | GBC Ibimaster 500 Manual ProClick Binding System | Office Supplies | 19024.50 | 0.8282 | 7.51 |
| 7 | Hewlett Packard LaserJet 3310 Copier | Technology | 18839.69 | 0.8201 | 8.33 |
| 8 | HP Designjet T520 Inkjet Large Format Printer | Technology | 18374.90 | 0.7999 | 9.13 |
| 9 | GBC DocuBind P400 Electric Binding System | Office Supplies | 17965.07 | 0.7820 | 9.91 |
| 10 | High Speed Automatic Electric Letter Opener | Office Supplies | 17030.31 | 0.7414 | 10.65 |

### b) Pareto de ganancias

| Total productos | Productos que hacen el 80% | % de productos | Con ganancia | Con pérdida | % acumulado máximo |
|----------------:|---------------------------:|---------------:|-------------:|------------:|-------------------:|
| 1894 | 167 | 8.82 | 1584 | 304 | 126.92 |

Top 10 por contribución a ganancias:

| Pos. | Producto | Categoría | Ganancia | % individual | % acumulado |
|-----:|----------|-----------|---------:|-------------:|------------:|
| 1 | Canon imageCLASS 2200 Advanced Copier | Technology | 25199.93 | 8.7989 | 8.80 |
| 2 | Fellowes PB500 Electric Punch Plastic Comb Binding Machine | Office Supplies | 7753.04 | 2.7071 | 11.51 |
| 3 | Hewlett Packard LaserJet 3310 Copier | Technology | 6983.88 | 2.4385 | 13.94 |
| 4 | Canon PC1060 Personal Laser Copier | Technology | 4570.93 | 1.5960 | 15.54 |
| 5 | HP Designjet T520 Inkjet Large Format Printer | Technology | 4094.98 | 1.4298 | 16.97 |
| 6 | Ativa V4110MDD Micro-Cut Shredder | Technology | 3772.95 | 1.3174 | 18.29 |
| 7 | 3D Systems Cube Printer, 2nd Generation, Magenta | Technology | 3717.97 | 1.2982 | 19.59 |
| 8 | Plantronics Savi W720 Multi-Device Wireless Headset System | Technology | 3696.28 | 1.2906 | 20.88 |
| 9 | Ibico EPK-21 Electric Binding System | Office Supplies | 3345.28 | 1.1681 | 22.04 |
| 10 | Zebra ZM400 Thermal Label Printer | Technology | 3343.54 | 1.1674 | 23.21 |

## Interpretación
En ventas, 423 productos, equivalentes al 22,3 % del catálogo, concentraron el 80 % del total. El resultado se acerca a la regla 80/20. La ganancia se concentró aún más. Bastaron 167 productos, el 8,8 % del catálogo, para alcanzar el 80 % de la ganancia neta.

## Comparación ventas vs. ganancias
El acumulado de ganancia llegó al 126,92 % antes de volver al 100 %. Esto ocurre porque el cálculo usa como referencia la ganancia neta total. Al ordenar los productos de mayor a menor, primero se suman las ganancias y, al final, las pérdidas de 304 productos reducen el acumulado hasta el 100 %. La Canon imageCLASS 2200 aportó por sí sola el 8,8 % de la ganancia neta. Technology ocupó ocho de los diez primeros puestos por ganancia. Cisco TelePresence y las sillas HON 5400 aparecieron entre los primeros por ventas y quedaron fuera de los primeros puestos por ganancia.

## Conclusión
Una parte pequeña del catálogo sostiene la mayor parte de la ganancia. Si el objetivo es mejorar la rentabilidad, el ranking de ganancias permite identificar qué productos sostienen el resultado y cuáles lo reducen, incluso cuando sus ventas son altas.

## Evidencia
- `evidencias/p8_pareto.png`

SELECT * FROM videojuegos;

select * from videojuegos limit 10;

-- Identificacion de Valores nulos
SELECT 
		COUNT(*) AS Total_Filas,
        COUNT(CASE WHEN Name IS NULL THEN 1 END) AS Nulos_Nombre,
        COUNT(CASE WHEN Year IS NULL THEN 1 END) AS Nulos_Año,
        COUNT(CASE WHEN Publisher IS NULL THEN 1 END) AS Nulos_Publicado
FROM videojuegos;

-- JUego mas vendido para comprender el mundo gamer
SELECT 
	Name,
    Platform,
    Genre,
    Global_Sales
FROM 
	videojuegos
ORDER BY 
	Global_Sales DESC
LIMIT 1;

-- Frecuencia de ventas por genero
SELECT 
	Genre, 
    COUNT(*) AS Total_Juegos,
    SUM(Global_Sales) AS Ventas_Totales_USD_Millones
FROM videojuegos
GROUP BY 
	Genre
ORDER BY 
	Ventas_Totales_USD_Millones DESC;

-- Ventas por año
SELECT 
	Year,
    SUM(Global_Sales) AS Ventas_Anuales
FROM 
	videojuegos
group by
	Year
order by
	Ventas_Anuales DESC;
    
-- Top 5 de editores
select 
	Publisher,
    sum(Global_Sales) AS Ventas_Generadas,
    count(*) AS Total_Juegos_Publicados
from
	videojuegos
group by
	Publisher
order by 
	Ventas_Generadas DESC
limit 5;

-- Ranking Juegos por plataforma
SELECT
    Name,
    Platform,
    Global_Sales,
    RANK() OVER (
        PARTITION BY Platform
        ORDER BY Global_Sales DESC
    ) AS Sales_Rank_Por_Plataforma
FROM
    videojuegos
WHERE
    Platform IN ('PS4', 'X360', 'PC') -- Filtra las plataformas que te interesan
ORDER BY
    Platform,
    Sales_Rank_Por_Plataforma
LIMIT 15;

-- Comparacion de Ventas REgionales
SELECT
    Genre,
    SUM(NA_Sales) AS Ventas_Norteamerica,
    SUM(EU_Sales) AS Ventas_Europa,
    SUM(JP_Sales) AS Ventas_Japon,
    SUM(Other_Sales) AS Ventas_Otras_Regiones,
    (SUM(NA_Sales) / SUM(Global_Sales)) * 100 AS Porcentaje_Norteamerica
FROM
    videojuegos
GROUP BY
    Genre
ORDER BY
    Porcentaje_Norteamerica DESC;
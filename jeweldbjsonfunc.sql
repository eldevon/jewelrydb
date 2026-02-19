-- (JSON Functions) - Store product attributes as JSON (mysql 5.7+)
ALTER TABLE Products 
ADD COLUMN Attributes JSON;

-- Update with JSON data
UPDATE Products 
SET Attributes = JSON_OBJECT(
    'material', 'gold',
    'karat', 18,
    'gemstones', JSON_ARRAY('diamond', 'sapphire'),
    'weight_grams', 5.2
)
WHERE ProductID = 1;

-- Query JSON data
SELECT 
    Name,
    JSON_EXTRACT(Attributes, '$.material') AS Material,
    JSON_EXTRACT(Attributes, '$.karat') AS Karat,
    JSON_LENGTH(JSON_EXTRACT(Attributes, '$.gemstones')) AS GemstoneCount
FROM Products
WHERE JSON_EXTRACT(Attributes, '$.material') = '"gold"';

-- Add full-text index for product search
ALTER TABLE Products 
ADD FULLTEXT(Name, Description);

-- Search products using natural language
SELECT 
    ProductID,
    Name,
    Description,
    MATCH(Name, Description) AGAINST('gold diamond necklace' IN NATURAL LANGUAGE MODE) AS RelevanceScore
FROM Products
WHERE MATCH(Name, Description) AGAINST('gold diamond necklace' IN NATURAL LANGUAGE MODE)
ORDER BY RelevanceScore DESC;

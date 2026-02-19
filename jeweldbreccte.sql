-- (A Recursive CTE) - Creating a product hierarchy table
CREATE TABLE ProductHierarchy (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100),
    ParentCategoryID INT,
    FOREIGN KEY (ParentCategoryID) REFERENCES ProductHierarchy(CategoryID)
);

-- Recursive CTE to get full category path
WITH RECURSIVE CategoryPath AS (
    -- Anchor member
    SELECT 
        CategoryID,
        CategoryName,
        ParentCategoryID,
        CategoryName AS FullPath
    FROM ProductHierarchy
    WHERE ParentCategoryID IS NULL
    
    UNION ALL
    
    -- Recursive member
    SELECT 
        ph.CategoryID,
        ph.CategoryName,
        ph.ParentCategoryID,
        CONCAT(cp.FullPath, ' > ', ph.CategoryName)
    FROM ProductHierarchy ph
    JOIN CategoryPath cp ON ph.ParentCategoryID = cp.CategoryID
)
SELECT * FROM CategoryPath;

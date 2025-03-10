INSERT INTO @temp
SELECT sesa_id, name
FROM mst_users
WHERE ([level] = 'mqe' OR [level] = 'admin') 
  AND email <> '' 
  AND role LIKE '%Engineer%'
  AND (
    status IS NULL
    OR (
      status = 'Active' 
      AND week_Active IS NOT NULL 
      AND (CONCAT(YEAR(week_Active), '-W', RIGHT('0' + CAST(DATEPART(WEEK, week_Active) AS VARCHAR), 2))) 
          BETWEEN @weekfrom AND @weekto
    )
    OR (
      status = 'NotActive' 
      AND week_NotActive IS NOT NULL 
      AND (CONCAT(YEAR(week_NotActive), '-W', RIGHT('0' + CAST(DATEPART(WEEK, week_NotActive) AS VARCHAR), 2))) 
          BETWEEN @weekfrom AND @weekto
      AND @weekto <= '2025-W04'
      AND NOT EXISTS (
        SELECT 1 FROM mst_users 
        WHERE ([level] = 'mqe' OR [level] = 'admin') 
          AND email <> '' 
          AND role LIKE '%Engineer%'
          AND status = 'Active' 
          AND week_Active IS NOT NULL 
          AND (CONCAT(YEAR(week_Active), '-W', RIGHT('0' + CAST(DATEPART(WEEK, week_Active) AS VARCHAR), 2))) 
              BETWEEN @weekfrom AND @weekto
      )
    )
  );

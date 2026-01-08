USE blogdb;

-- 1
SELECT 
    user_id,
    name,
    email,
    phone,
    role,
    IF(
        phone IS NOT NULL 
        AND phone <> '' 
        AND email LIKE '%@company.com',
        'COMPLETE',
        IF(
            (phone IS NOT NULL AND phone <> '')
            OR email LIKE '%@company.com',
            'PARTIAL',
            'INCOMPLETE'
        )
    ) AS contact_profile
FROM user
ORDER BY
    IF(
        phone IS NOT NULL 
        AND phone <> '' 
        AND email LIKE '%@company.com',
        1,
        IF(
            (phone IS NOT NULL AND phone <> '')
            OR email LIKE '%@company.com',
            2,
            3
        )
    ),
name ASC;

-- 2
SELECT
    name,
    UPPER(name) AS name_formatted,
    LENGTH(name) AS name_length,
    IF(LENGTH(name) <= 4, 'SHORT', 'LONG') AS name_type
FROM user
ORDER BY name_length DESC
LIMIT 10;


-- 3
SELECT
    post_id,
    title,
    post_date,
    IF(post_date IS NULL, 'NO DATE', 'WITH DATE') AS date_status
FROM post
ORDER BY
    date_status ASC,
    post_id DESC;


-- 4
SELECT
    name,
    email,
    registration_date,
    DATEDIFF(CURDATE(), registration_date) AS days_active,
    IF(
        DATEDIFF(CURDATE(), registration_date) > 365,
        'OLD',
        'RECENT'
    ) AS user_label,
    CONCAT(
        'User ',
        name,
        ' registered ',
        DATEDIFF(CURDATE(), register_date),
        ' days ago'
    ) AS message
FROM user
WHERE
    register_date IS NOT NULL
    AND (
        email LIKE '%@company.com'
        OR email LIKE '%@example.com'
    )
ORDER BY
    days_active DESC,
    name ASC;


-- 5
SELECT 
    comment_id,
    content,
    user_id,
    post_id,
    CASE
        WHEN content IS NULL OR content = '' THEN 'EMPTY'
        WHEN LOWER(content) LIKE '%error%' THEN 'HAS ERROR'
        ELSE 'OK'
    END AS alert
FROM comment
ORDER BY comment_id DESC
LIMIT 15;


-- 6
SELECT 
    name,
    email,
    role,
    register_date,
    -- Campo calculado 'level'
    CASE
        WHEN role = 'admin' 
             OR (role = 'verified' AND phone IS NOT NULL AND phone <> '') THEN 'TOP'
        WHEN role = 'moderator' 
             OR email LIKE '%@example.com' THEN 'MEDIUM'
        ELSE 'LOW'
    END AS level,
    -- Campo calculado 'priority' numérico
    CASE
        WHEN role = 'admin' 
             OR (role = 'verified' AND phone IS NOT NULL AND phone <> '') THEN 1
        WHEN role = 'moderator' 
             OR email LIKE '%@example.com' THEN 2
        ELSE 3
    END AS priority
FROM user

WHERE name LIKE '%a%'           -- Nombre contiene la letra 'a'
  AND role <> 'pending'         -- Rol no es 'pending'
ORDER BY priority ASC, register_date DESC;


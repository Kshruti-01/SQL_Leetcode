/* Write your T-SQL query statement below */
SELECT
    user_id,
    name,
    mail
FROM
    Users
WHERE
    -- 1. Exactly one '@'
    LEN(mail) - LEN(REPLACE(mail, '@', '')) = 1

    -- 2. '@' is not the first character
    AND CHARINDEX('@', mail) > 1

    -- 3. Domain is exactly '@leetcode.com' (case-sensitive)
    AND SUBSTRING(mail, CHARINDEX('@', mail), LEN(mail)) COLLATE Latin1_General_CS_AS = '@leetcode.com'

    -- 4. First character is a letter
    AND SUBSTRING(mail, 1, 1) COLLATE Latin1_General_CS_AS LIKE '[a-zA-Z]'

    -- 5. Prefix contains only allowed characters (binary-safe)
    AND PATINDEX(
        '%[^a-zA-Z0-9_.-]%',
        SUBSTRING(mail, 1, CHARINDEX('@', mail) - 1) COLLATE Latin1_General_BIN
    ) = 0;

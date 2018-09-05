INSERT INTO
    T_USR
SELECT
    LPAD((MAX(CAST(USR_NUM) AS SIGNED) + 1),5,"0")
    ,LPAD(hex(cast(REVERSE(LPAD((MAX(CAST(USR_NUM) AS SIGNED) + 1),5,"0")) as signed)),5,"0")
    ,_usr_id
    ,_usr_name
    ,_hsh
    ,0
    ,null
    ,NOW(3)
    ,NOE(3)
FROM
    T_USR
;
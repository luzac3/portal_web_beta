DROP PROCEDURE IF EXISTS register_user;
DELIMITER //
-- ********************************************************************************************
-- ユーザーを登録する
--
-- 【処理概要】
--  ユーザを登録し、ユーザ通番を取得する
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _user_id             ：ユーザID
--   _user_name           ：ユーザ名
--   _hash                 :ハッシュ
--
--
-- 【戻り値】
--      exit_cd            : exit_cd
--      正常：0
--      異常：99
-- --------------------------------------------------------------------------------------------
-- 【更新履歴】
--  2018.6.05 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `register_user`(
    IN `_user_id` VARCHAR(40)
    , IN `_user_name` VARCHAR(40)
    , IN `_hash` CHAR(10)
    , OUT `exit_cd` INTEGER
)
COMMENT 'ユーザー登録'

BEGIN

-- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        SELECT @sqlstate, @errno, @text;
        ROLLBACK;
        SET exit_cd = 99;
    END;

    SET @now_date = NOW(3);

    INSERT INTO
        T_USR
    (
        USR_NUM
        ,USR_CD
        ,USR_ID
        ,USR_NAME
        ,HSH
        ,RH_FLG
        ,BLD_TYP_CD
--        ,ICN_URL
        ,TRK_NTJ
        ,KSN_NTJ
    )
    SELECT
        LPAD((MAX(CAST(USR_NUM AS SIGNED)) + 1),5,"0")
        ,LPAD(hex(cast(REVERSE(LPAD((MAX(CAST(USR_NUM AS SIGNED)) + 1),5,"0")) as signed)),5,"0")
        ,_user_id
        ,_user_name
        ,_hash
        ,0
        ,null
--        ,null
        ,@now_date
        ,@now_date
    FROM
        T_USR
    ;

set @query = CONCAT("
    SELECT
        USR_CD
    FROM
        T_USR
    WHERE
        TRK_NTJ = '",@now_date,"'
    ;
");

    SET @query_text = @query;

    -- 実行
    PREPARE main_query FROM @query_text;
    EXECUTE main_query;
    DEALLOCATE PREPARE main_query;

    SET exit_cd = 0;

END
//
DELIMITER ;
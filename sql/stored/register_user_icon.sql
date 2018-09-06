DROP PROCEDURE IF EXISTS register_user_icon;
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
--   _user_cd             ：ユーザコード
--   _url                 ：URL
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
CREATE PROCEDURE `register_user_icon`(
    IN `_user_cd` VARCHAR(20)
    , IN `_url` VARCHAR(100)
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

    UPDATE
        T_USR
    SET
        ICN_URL = _url
    WHERE
        USR_CD = _user_cd
    ;

    SET exit_cd = 0;

END
//
DELIMITER ;
DROP PROCEDURE IF EXISTS check_cd;
DELIMITER //
-- ********************************************************************************************
-- check_cd コード番号が存在するかチェックする
--
-- 【処理概要】
--  イベントとユーザーの番号が存在するかチェックする
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_cd           ：イベントCD
--   _user_cd            ：ユーザCD
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
CREATE PROCEDURE `check_cd`(
    IN `_event_cd` CHAR(5)
    , IN `_user_cd` CHAR(5)
    , OUT `exit_cd` INTEGER
)
COMMENT '写真許可判定'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    SELECT
        CASE
            WHEN(
                EXISTS(
                    SELECT
                        *
                    FROM
                        T_USR
                    WHERE
                        USR_CD = _user_cd
                )
                AND
                EXISTS(
                    SELECT
                        *
                    FROM
                        T_EVNT_MSTR
                    WHERE
                        EVNT_CD = _event_cd
                )
            ) THEN '0'
            ELSE '1' END INTO @exit_cd
    ;

END
//
DELIMITER ;

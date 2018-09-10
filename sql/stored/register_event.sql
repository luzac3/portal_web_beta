DROP PROCEDURE IF EXISTS register_event;
DELIMITER //
-- ********************************************************************************************
-- register_event イベントを登録する
--
-- 【処理概要】
--  イベントを登録する
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--  _event_name            :
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
CREATE PROCEDURE `register_event`(
        IN `_event_name` VARCHAR(40)
        ,IN `_strt_yr` CHAR(4)
        ,IN `_end_yr` CHAR(4)
        ,IN `_strt_mnth` CHAR(2)
        ,IN `_end_mnth` CHAR(2)
        ,IN `_strt_dt` CHAR(2)
        ,IN `_end_dt` CHAR(2)
        ,IN `_strt_hr` CHAR(2)
        ,IN `_end_hr` CHAR(2)
        ,IN `_strt_mnt` CHAR(2)
        ,IN `_end_mnt` CHAR(2)
        ,IN `_strt_scnd` CHAR(2)
        ,IN `_end_scnd` CHAR(2)
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

    INSERT INTO
        T_EVNT_MSTR
    (
        EVNT_NUM
        ,EVNT_CD
        ,EVNT_NAME
        ,STRT_YR
        ,END_YR
        ,STRT_MNTH
        ,END_MNTH
        ,STRT_DT
        ,END_DT
        ,STRT_HR
        ,END_HR
        ,STRT_MNT
        ,END_MNT
        ,STRT_SCND
        ,END_SCND
        ,TRK_NTJ
        ,KSN_NTJ
    )
    SELECT
        LPAD((MAX(CAST(EVNT_NUM AS SIGNED)) + 1),5,"0")
        ,LPAD(hex(cast(REVERSE(LPAD((MAX(CAST(EVNT_NUM AS SIGNED)) + 1),5,"0")) as signed)),5,"0")
        ,_event_name
        ,_strt_yr
        ,_end_yr
        ,_strt_mnth
        ,_end_mnth
        ,_strt_dt
        ,_end_dt
        ,_strt_hr
        ,_end_hr
        ,_strt_mnt
        ,_end_mnt
        ,_strt_scnd
        ,_end_scnd
        ,NOW(3)
        ,NOW(3)
    FROM
        T_EVNT_MSTR
    ;

    SET exit_cd = 0;

END
//
DELIMITER ;
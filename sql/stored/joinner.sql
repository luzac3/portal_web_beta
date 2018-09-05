DROP PROCEDURE IF EXISTS joinner;
DELIMITER //
-- ********************************************************************************************
-- joinner 参加者を取得するクエリ
--
-- 【処理概要】
--  参加者一覧取得処理
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_num           ：イベント通番
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
CREATE PROCEDURE `joinner`(
    IN `_event_num` CHAR(5)
    , OUT `exit_cd` INTEGER
)
COMMENT '参加者一覧取得処理'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    SELECT
        TU.USR_NUM
        ,TU.USR_NAME
        ,TU.HSH
        ,TU.RH_FLG
        ,TU.BLD_TYP_CD
        ,TJE.EVNT_WK_CD
        ,TJE.SNS_AT_FLG
        ,TJE.IMG_AT_FLG_SHT
        ,TJE.IMG_AT_FLG_SHTD
        ,TLF.FRNDS_CD
        ,TP.PSTN_CD
        ,CPC.PSTN_NAME
        ,CPC.ATHRTY_LVL
    FROM
        T_USR TU --------------------------------------------------ユーザ情報 TU
    LEFT OUTER JOIN
        T_JN_EVNT TJE ---------------------------------------------イベント参加ユーザ情報 TJE
    ON
        TU.EVNT_NUM = TJE.EVNT_NUM
    AND
        TU.USR_NUM = TJE.USR_NUM
    LEFT OUTER JOIN
        T_LK_FRNDS TLF
    ON
        TU.EVNT_NUM = TLF.EVNT_NUM
    AND
        TU.USR_NUM = TLF.USR_NUM
    LEFT OUTER JOIN
        C_FRNDS_CD CFC
    ON
        TLF.FRNDS_CD = CFC.FRNDS_CD
    LEFT OUTER JOIN
        T_PSTN TP
    ON
        TU.EVNT_NUM = TP.EVNT_NUM
    AND
        TU.USR_NUM = TP.USR_NUM
    LEFT OUTER JOIN
        C_PSTN_CD CPC
    ON
        TP.PSTN_CD = CPC.PSTN_CD
    WHERE
        TU.EVNT_NUM = _event_num
    ;

    SET exit_cd = 0;

END
//
DELIMITER ;

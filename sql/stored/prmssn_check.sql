DROP PROCEDURE IF EXISTS prmssn_check;
DELIMITER //
-- ********************************************************************************************
-- prmssn_check 写真の申請許可が通っているか確認する
--
-- 【処理概要】
--  写真の申請許可が通っているかの確認を行い、通っていればUPDATEを行う
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_num           ：イベント通番
--   _applcnt_user_num    ：申請者ユーザ通番
--   _pictr_no            ：写真番号
--   _dl_sns_judg_cd      ：DL/SNS判定コード
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
CREATE PROCEDURE `prmssn_check`(
    IN `_event_num` CHAR(5)
    , IN `_applcnt_user_num` CHAR(5)
    , IN `_pictr_no` CHAR(4)
    , IN `_dl_sns_judg_cd` CHAR(1)
    , OUT `exit_cd` INTEGER
)
COMMENT '写真許可判定'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    UPDATE
        対写真要求
    SET
        許可コード = (
            SELECT
                CASE
                    WHEN NOT EXISTS(
                        SELECT
                            *
                        FROM
                            PICTR_RQST_APPLCTN_PRMTTD
                        WHERE
                            DL_SNS_JUDG_CD = _dl_sns_judg_cd
                        AND
                            EVNT_NUM = _event_num
                        AND
                            APPLCNT_USER_NUM = _applcnt_user_num
                        AND
                            PCTR_NO = _pictr_no
                        AND
                            -- 許可コード2以外がいない(全許可)
                            PRMSSN_CD <> '2'
                    ) THEN '2'
                    WHEN EXISTS (
                        SELECT
                            *
                        FROM
                            PICTR_RQST_APPLCTN_PRMTTD
                        WHERE
                            DL_SNS_JUDG_CD = _dl_sns_judg_cd
                        AND
                            EVNT_NUM = _event_num
                        AND
                            APPLCNT_USER_NUM = _applcnt_user_num
                        AND
                            PCTR_NO = _pictr_no
                        AND
                            -- 許可コード3が一つでも存在(差し戻し)
                            PRMSSN_CD = '3'
                    ) THEN '3'
                    WHEN (
                        NOT EXISTS(
                            SELECT
                                *
                            FROM
                                PICTR_RQST_APPLCTN_PRMTTD
                            WHERE
                                DL_SNS_JUDG_CD = _dl_sns_judg_cd
                            AND
                                EVNT_NUM = _event_num
                            AND
                                APPLCNT_USER_NUM = _applcnt_user_num
                            AND
                                PCTR_NO = _pictr_no
                            AND
                                -- 許可コード3が存在しない
                                PRMSSN_CD = '3'
                        )
                        AND
                        EXISTS(
                            SELECT
                                *
                            FROM
                                PICTR_RQST_APPLCTN_PRMTTD
                            WHERE
                                DL_SNS_JUDG_CD = _dl_sns_judg_cd
                            AND
                                EVNT_NUM = _event_num
                            AND
                                APPLCNT_USER_NUM = _applcnt_user_num
                            AND
                                PCTR_NO = _pictr_no
                            AND
                                -- 許可コード2以外が存在する
                                PRMSSN_CD <> '2'
                        )
                    ) THEN '1'
                    ELSE DL許可コード END
        )
    WHERE
        EVNT_NUM = _event_num
    AND
        PCTR_NO = _pctr_no
    AND
        APPLCNT_USR_NUM = _applcnt_user_num
    AND
        DL_SNS_JUDG_CD = _dl_sns_judg_cd
    ;

    SET exit_cd = 0;

END
//
DELIMITER ;

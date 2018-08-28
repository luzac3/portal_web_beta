DROP PROCEDURE IF EXISTS joinner;
DELIMITER //
-- ********************************************************************************************
-- joinner 参加者を取得するクエリ
--
-- 【処理概要】
--  dl/SNSアップロード許可申請に対する許可を行う
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_num           ：イベント通番
--   _applcnt_user_num    ：申請者ユーザ通番
--   _athrzruser_num      ：承認者ユーザ通番
--   _pictr_no            ：写真番号
--   _prmssn_cd           ：許可コード
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
CREATE PROCEDURE `dl_sns_prmssn`(
    IN `_event_num` CHAR(5)
    , IN `_applcnt_user_num` CHAR(5)
    , IN `_athrzruser_num` CHAR(5)
    , IN `_pictr_no` CHAR(4)
    , IN `_prmssn_cd` CHAR(1)
    , OUT `exit_cd` INTEGER
)
COMMENT 'dl/SNSアップロード許可'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    UPDATE
        PICTR_RQST_APPLCTN_PRMTTD
    SET
        PRMSSN_CD = _prmssn_cd
    WHERE
        EVNT_NUM = _event_num
    AND
        PICTR_NO = _pictr_no
    AND
        APPLCNT_USR_NUM = _applcnt_user_num
    AND
        ATHRZR_USR_NUM = _athrzr_user_num
    ;

    call prmssn_check(_event_num_applcnt_user_num,_athrzruser_num,_pictr_no,_prmssn_cd);

    SET exit_cd = 0;

END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS emergency;
DELIMITER //
-- ********************************************************************************************
-- emergency 緊急事態データ記録
--
-- 【処理概要】
--  緊急事態が発生した際、発信元情報などを記録する
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_num           ：イベント通番
--   _user_num            ：ユーザ通番
--   _emergency_no        ：ユーザ通番
--   _lttd                ：緯度
--   _lngtd               ：経度
--   _alttd               ：高度
--   _accrcy              ：緯度経度の誤差
--   _alttd_accrcy        ：高度の誤差
--   _hdng                ：方角
--   _spd                 ：速度
--   _date                ：記録日時
--   _err                 ：エラー
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
CREATE PROCEDURE `emergency`(
    IN `_event_num` CHAR(5)
    , IN `_user_num` CHAR(5)
    , IN `_emergency_no` VARCHAR(10)
    , IN `_lttd` VARCHAR(10)
    , IN `_lngtd` VARCHAR(10)
    , IN `_alttd` VARCHAR(10)
    , IN `_accrcy` VARCHAR(10)
    , IN `_alttd_accrcy` VARCHAR(10)
    , IN `_hdng` VARCHAR(10)
    , IN `_spd` CHAR(10)
    , IN `_date` DATETIME(3)
    , IN `_err` VARCHAR(100)
    , OUT `exit_cd` INTEGER
)
COMMENT '緊急事態データ記録'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    INSERT INTO
        EMRGNCY
    VALUES(
        _event_num
        ,_user_num
        ,_emergency_no
        ,_lttd
        ,_lngtd
        ,_alttd
        ,_accrcy
        ,_alttd_accrcy
        ,_hdng
        ,_spd
        ,_date
        ,_err
    )
    ;
    SET exit_cd = 0;

END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS pict_fav;
DELIMITER //
-- ********************************************************************************************
-- pict_fav 写真に対するお気に入りフラグ
--
-- 【処理概要】
--  写真に対するお気に入りのフラグをアップデートする
--
--
-- 【呼び出し元画面】
--   インデックス
--
-- 【引数】
--   _event_num           ：イベント通番
--   _user_num            ：ユーザ通番
--   _pictr_no            ：写真番号
--   _fav_flg             ：お気に入りフラグ
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
CREATE PROCEDURE `pict_fav`(
    IN `_event_num` CHAR(5)
    , IN `_user_num` CHAR(5)
    , IN `_pictr_no` CHAR(4)
    , IN `_fav_flg` TINYINT
    , OUT `exit_cd` INTEGER
)
COMMENT 'お気に入りフラグ変更'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    UPDATE
        T_PICTR_FAV
    SET
        FAV_FLG = _fav_flg
    WHERE
        EVNT_NUM = _event_num
    AND
        PICTR_NO = _pictr_no
    AND
        USR_NUM = _user_num
    ;

    SET exit_cd = 0;

END
//
DELIMITER ;

<?php
    require_once("API/php/tcpdf/tcpdf.php");
    require_once("API/php/tcpdf/fpdi.php");

    $receipt = new FPDI();

    // pdfの余白を設定
    $receipt->setMargin(0,0,0);

    // ヘッダーの出力を無効化
    $receipt->setPrintHeader(false);

    // フッターの出力を無効化
    $receipt->setPrintFooter(false);

    // フォントを登録
    $fontPathRegular = $this->getLibPath() . "API/php/tcpdf/fonts/migmix-2p-regular.ttf";
    $regularFont = $receipt->addTTFfont($fontPathRegular, '', '', 32);

    $fontPathBold = $this->getLibPath() . "API/php/tcpdf/fonts/migmix-2p-bold.ttf";
    $regularFont = $receipt->addTTFfont($fontPathBold, '', '', 32);

    // ページを追加
    $receipt->AddPage();

    // テンプレートを読み込み
    $receipt->setSourceFile($this->getLibPath() . "API/php/tcpdf/fonts/receipt.pdf");

    // 読み込んだPDFの1ページ目のインデックスを取得
    $tplIdx = $receipt->importPage(1);

    // 読み込んだPDFの1ページ目をテンプレートとして使用
    $receipt->useTemplate($tplIdx, null,null,null,null,true);

    // 書き込む文字列のフォントを指定
    $receipt->SetFont($regularFont, '', 11);

    // 書き込む文字列の文字色を指定
    $receipt->SetTextColor(255, 0, 0);

    // テーブル情報を取得、DLキー(ユーザ通番)ごとに必要な情報をインプット
    // コード記載位置はカードデータの一部として座標で取得する
    // カードを縦で使うか横で使うかもここで指定

    $num = 0;

    forEach($result as $row){
        // カードの初期値設定
        if($num == 0){
            $prntX = "";
            $prntY = "";
        }else{
            // 書き込み位置をずらす

            // 縦書きの場合
            if($row["TD_CD"] == "1"){
                if($num %2 == 0){
                    $prntX = parseInt($printX) + $row["CRD_WDTH"];
                    // Y座標を初期位置に
                    $sprntY = "";
                }else{
                    $prntY = parseInt($prntY) + $row["CRD_HGHT"];
                }
            }else{
                if($num %2 == 0){
                    // X座標を初期位置に
                    $sprntX = "";
                    $prntY = parseInt($printY) + $row["CRD_HGHT"];
                }else{
                    $prntX = parseInt($prntX) + $row["CRD_WDTH"];
                }
            }
        }

        // カード画像を書き込む
        $receipt->Image($row["CRD_DSGN_PCTR"],$prntX,$prntY);

        // QRコードを書き込む
        $receipt->Image($row["QR_PCTR"],$prntX + $row["QR_X_PS"],$prntY + $row["QR_Y_PS"], $row["QR_HGHT"], $row["QR_WDTH"]);

        // 文字列(コード)を書き込む
        $receipt->Text($row["PRNT_CD"], $prntX + $row["PRNT_CD_NO_X_PS"], $prntY + $row["PRNT_CD_NO_Y_PS"]);

        $num++;

        if($num == 0){
            // ページを追加
            $receipt->AddPage();
            $num = 0;
        }
    }
    // receiptをBLOBで保存
    $arg_arr = array(
        "EVNT_NUM"=>""
        ,"PDF"=>$receipt
        ,"FL_NAME"=>""
    );

    // 作成完了したら制御を戻してPDF出力可能を提示(ボタン提示)
    // 画像等の保存に際して、BindParamを作っている関数の更新が必要　なぜならBlob型に対応してないから
?>
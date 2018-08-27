$(document).ready(function(){
    $("#emergency").on("click",function(){
        // 緊急事態コール
        const options = {
            // 高精度位置情報取得
            enableHightAccuracy: true
            ,maimumAge:0
            ,timeout: 120000
        }

        function get_pos(){
            if(navigator.geolocation){
                navigator.geolocation.getCurrentPosition(success_callback,error_callback,options);

                // 読み込みアニメーションを表示
            }else{
                // 対応していない場合はアラート表示
                alert("位置情報取得に対応していません");
            }
        }

        function success_callback(position){
            // 取得成功の場合
            // 情報取得完了を表示、アニメーションをきる

            // 緯度
            const latitude = position.coords.latitude;

            // 経度
            const longitude = position.coords.longitude;

            // 高度
            const altitude = position.coords.altitude;

            // 緯度経度の誤差
            const accuracy = position.coords.accuracy;

            // 高度の誤差
            const altitude_accuracy = position.coords.altitudeAccuracy;

            // 方角
            const heading = position.coords.heading;

            // 速度
            const speed = position.coords.speed;

            // 位置情報を記録した時刻のミリ秒
            const timestamp = position.coords.timestamp;

            // タイムスタンプを変換
            const date = new Date(timestamp);

            // Googleマップのリンクを作成
            const url = "https://map.google.co.jp/maps?="
                + latitude
                + ","
                + longitude
                + "+%28%E7%8F%BE%E5%9C%A8%E4%BD%8D%E7%BD%AE%29&iwloc=A";

            // メッセージを作成・送信、および緊急事態ログにデータを記録
            const arg_arr = {
                event_num:""
                ,user_num:""
                ,latitude:latitude
                ,longitude:longitude
                ,altitude:altitude
                ,accuracy:accuracy
                ,altitude_accuracy:altitude_accuracy
                ,heading:heading
                ,speed:speed
                ,date:date
                ,url:url
            }
        }

        function error_callback(error){
            // データ取得失敗を表示
            // アニメーションを停止

            // コード
            const code = error.code;

            // メッセージ
            const message = error.message;

            let error = "";

            switch(code){
              case error.PERMISSION_DENIED:
                error = "GeolocationAPIのアクセス許可なし";
                break;
              case error.POSITTION_UNAVAILABLE:
                error = "現在の位置情報特定失敗";
                break;
              case error.TIMEOUT:
                error = "指定されたタイムアウト時間内に現在の位置情報特定に失敗";
                break;
            }

            const date = new Date();

            const now =
                date.getFullYear()
                + "-"
                + date.getMonth()
                + "-"
                + date.getHour()
                + ":"
                + date.getMinutes()
                + ":"
                + date.getSeconds()
                ;

            // エラーコードをテーブルに反映、企画者に送付
            // エラーは発信者のみに送付
            // 位置情報が取れなくても、緊急事態コードは全員に配信
            const arg_arr = {
                event_num:""
                ,user_num:""
                ,date:now
            };
        }
    });
});
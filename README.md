# Godot4
## TileMap sample 001
タイルマップを使ったゲームです。<br>
中学生、高校生向けのプログラミング教育用のネタとして用意しています。<br>

### フリー素材/著作権表示

#### 音源素材:BGM『OtoLogic』 
打撃音 <br>
シャッター音 <br>
https://otologic.jp

#### 音源素材:BGM『MusMus』
魔女っ婆タヱさん(ループ設定,2倍速再生)<br>
https://musmus.main.jp/

### 操作方法
キーボードの矢印キー（上下左右）を押すとプレイヤーが１マス動きます。<br>
『ドア』のタイルに入ることができたらステージクリアです。<br>
『ドア』が表示されていないときは、『レバー』や『ボタン』をオンにしてみてください。<br>
『矢印』タイルでは矢印の方向にしか進むことができません。<br>

### ステージ拡張
３つのステージをサンプルで用意しています。<br>
ステージ１～３を参考にしてステージを改良したり追加してみてください。

#### 取得方法
git clone https://github.com/amami-harhid/Godot4_tilemap_001.git

## 解説
### ステージごとのシーン
/resources/stage/Stage01.tscn<br>
/resources/stage/Stage02.tscn<br>
/resources/stage/Stage03.tscn<br>

### ステージごとのシーンにアタッチするスクリプト
/src/games/Game01.gd<br>
/src/games/Game02.gd<br>
/src/games/Game03.gd<br>

#### 継承
GameStageDetail < GameCommon < TileMap

ゲームを支配するような基本的なメソッドは GameCommonにて、少しだけステージ寄りのメソッドは GameStageDetail に書いています

### Player
/src/player/PlayerSprite2D.gd

#### 継承
BasePlayerSprite2D < Sprite2D

### Main
/src/main/Main.gd

#### 継承
MainDetail < MainCommon < Node2D

初期ステージ番号、ステージ数は MainDetail.gdに書かれています

## 効果音
効果音や音楽をつけてみました。

# これから頑張ること

## メニュー機能
ゲーム中に右クリックしたらメニューを表示し、リスタートなどをさせるようにしたいです<br>
ゆっくり対応します。


## スマホ版対応
スマホで試していないですが、多分動かない。うごくようにしたいです。<br>
ゆっくり対応します。

### タッチパネルFlick対応
疑似的に対応してみました。（操作確認中 Chromebook)

https://game.mirai-logic.com/tilemap_sample01/







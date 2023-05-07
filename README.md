# Gotod4
## TileMap sample 001
タイルマップを使ったゲームです。
中学生、高校生向けのプログラミング教育用のネタとして用意しています。

### 操作方法
キーボードの矢印キー（上下左右）を押すとプレイヤーが１マス動きます。
『ドア』のタイルに入ることができたらステージクリアです。
『ドア』が表示されていないときは、『レバー』や『ボタン』をオンにしてみてください。
『矢印』タイルでは矢印の方向にしか進むことができません。

### ステージ拡張
３つのステージをサンプルで用意しています。
ステージ１～３を参考にしてステージを改良したり追加してみてください。

#### 取得方法
git clone https://github.com/amami-harhid/Godot4_tilemap_001.git

## 解説
### ステージごとのシーン
/resources/stage/Stage01.tscn
/resources/stage/Stage02.tscn
/resources/stage/Stage03.tscn

### ステージごとのシーンにアタッチするスクリプト
/src/games/Game01.gd
/src/games/Game02.gd
/src/games/Game03.gd

#### 継承
GameStageDetail < GameCommon < TileMap

ゲームを支配する基本的なメソッドは GameCommonにて、少しだけステージ寄りのメソッドは GameStageDetail に書いています

### Player
/src/player/PlayerSprite2D.gd

#### 継承
BasePlayerSprite2D < Sprite2D

### Main
/src/main/Main.gd

#### 継承
MainDetail < MainCommon < Node2D

初期ステージ番号、ステージ数は MainDetail.gdに書かれています


#　これから頑張ること

## メニュー機能
ゲーム中に右クリックしたらメニューを表示し、リスタートなどをさせるようにしたいです
ゆっくり対応します。

## 効果音
効果音や音楽がならない無音状態です。楽しい音を鳴らしたいです。
ゆっくり対応します。

## スマホ版対応
スマホで試していないですが、多分動かない。うごくようにしたいです。ゆっくり対応します。






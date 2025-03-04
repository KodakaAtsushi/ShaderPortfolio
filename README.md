# 概要
ShaderGraphを用いて作成したエフェクト集です。
制作期間はそれぞれ１日ほどです。

### 水面シェーダー
動かすと揺れる水面シェーダー<br>
水面の傾きに相当する変数を可視化するための玉も表示しています。

https://github.com/user-attachments/assets/a9bad4e3-3528-4136-a39e-b62a87ce3865


### シールドシェーダー
衝突すると、その方向から伝播するようにエフェクトが発生します。

https://github.com/user-attachments/assets/5241a2da-52be-4ea9-8e27-4dc60658aa7d


### 爆発シェーダー
爆発の炎・煙のシェーダーです。<br>
球状のメッシュにマテリアルを設定しています。

https://github.com/user-attachments/assets/05e30389-481f-4ebd-96c0-98eaca9364b1


### 引用したスクリプト
Assets/Scripts/HLSLにあるTiledSimpleNoise.hlslは引用したものです。[引用元](https://qiita.com/yuji_yasuhara/items/cfe4b08e7438eca06eda)<br>
また、.gitignoreファイルについても引用したものです。[引用元](https://github.com/github/gitignore/blob/main/Unity.gitignore)

# 使用技術
Unity, ShaderGraph, C#

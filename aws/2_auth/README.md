# 認証基盤

+ OpenAMを利用
+ ECSで構築
+ ベースイメージはalpine
+ 利用するイメージはOpenAMをダウンロード(tag:latest)した後、GUIでsetting(tag:setting)した物を用いる

## コンテナへログイン

+ bashじゃなくてash

```
docker exec -ti auth ash
```

## ログ確認

```
aws logs filter-log-events --log-group-name awslogs-daifuku
```

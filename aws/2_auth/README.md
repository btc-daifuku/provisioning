# 認証基盤

+ OpenAMを利用
+ ECSで構築
+ ベースイメージはalpine

## コンテナへログイン

+ bashじゃなくてash

```
docker exec -ti auth ash
```

## ログ確認

```
aws logs filter-log-events --log-group-name awslogs-daifuku
```

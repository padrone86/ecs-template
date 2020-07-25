# APIモックサーバ
[JSON Server]() を利用して実装した。

## ローカル起動方法

```sh
$ docker build -t sample-api .
$ docker run -p 8000:8080 -d sample-api
```

## アクセス方法
```sh
$ curl http://localhost:8000/objects
```

# ruby-onestop-tokurei-gen

## 環境構築(Windows)
```
> git clone https://github.com/imo-tikuwa/ruby-onestop-tokurei-gen.git
> cd ruby-onestop-tokurei-gen
> bundle install --path vendor/bundle
> cd public
> npm ci
```
1. server/server.bat　を実行してサーバーを起動  
2. http://localhost/ にアクセス

## 環境構築(Linux)
pumaやunicornなどのWebサーバーは使わずにとりあえず確認できる環境構築を行う
```
# cd /usr/local
# git clone https://github.com/imo-tikuwa/ruby-onestop-tokurei-gen.git
# cd ruby-onestop-tokurei-gen
# bundle install --path vendor/bundle
# cd public
# npm ci
# ../server/server.sh
```
---
/etc/nginx/conf.d/onestop.imo-tikuwa.com.conf
```
server {
    server_name onestop.imo-tikuwa.com;
    access_log  /var/log/nginx/onestop.imo-tikuwa.com.access_log;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    location / {
        proxy_pass http://localhost:3000;
    }
}
```


## メモ
rbenvを使ってます。  
rubyのバージョンは2.6.0です。  
  
http://localhost/ にアクセスすると以下のようなフォームが表示されます。  
PDF作成ボタンをクリックすると入力した内容でPDFを出力します。  
![image](https://user-images.githubusercontent.com/48991931/71883715-54ff2580-317a-11ea-9133-0abbcac3dd37.png)


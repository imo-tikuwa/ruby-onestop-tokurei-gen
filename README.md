# ruby-onestop-tokurei-gen

## 環境構築(Windows)
```
> git clone https://github.com/imo-tikuwa/ruby-onestop-tokurei-gen.git
> cd ruby-onestop-tokurei-gen
> bundle install --path vendor/bundle
> cd public
> npm ci
> ../server/server.bat
```
1. http://localhost/ にアクセス

## 環境構築(Linux)
pumaやunicornなどのWebサーバーは使わずにとりあえず確認できる環境構築を行う
```
# cd /usr/local
# git clone https://github.com/imo-tikuwa/ruby-onestop-tokurei-gen.git
# cd ruby-onestop-tokurei-gen
# bundle install --path vendor/bundle
# cd public
# npm ci
# ../server/server.sh start
```
1. http://[public ip address]:3000/ にアクセス

## メモ
rbenvを使ってます。  
rubyのバージョンは2.6.0です。  
  
アクセスすると以下のようなフォームが表示されます。  
PDF作成ボタンをクリックすると入力した内容でPDFを出力します。  
![image](https://user-images.githubusercontent.com/48991931/71883715-54ff2580-317a-11ea-9133-0abbcac3dd37.png)


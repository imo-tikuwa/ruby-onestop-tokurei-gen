require 'sinatra'
require 'sinatra/reloader'
require 'thinreports'
require 'date'

# index.htmlを表示
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# PDFをダウンロードするルーティング
get '/download_pdf' do

  test1 = Time.now.strftime("%Y年%m月%d日 %H時%M分%S秒")
  file_name = Time.now.strftime("%Y%m%d%H%M%S") + '_onestop.pdf'
  file_path = 'output/' + file_name

  # PDF生成
  Thinreports::Report.generate(:filename => file_path, :layout => 'tlfs/onestop.tlf') do
    start_new_page

    # とりあえず決め打ちで意図した値が表示されることを確認
    page.item(:current_year).value("2")
    page.item(:current_month).value("1")
    page.item(:current_day).value("5")
    page.item(:name).value("いも　ちくわ")
    page.item(:name_kana).value("イモ　チクワ")
    page.item(:my_number).value("123456789012")
  end

  # PDFダウンロード
  stat = File::stat(file_path)
  send_file(file_path, :filename => file_name, :length => stat.size, :type => 'application/octet-stream')
end
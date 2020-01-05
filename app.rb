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
    page.item(:top_current_year).value("2")

    page.item(:current_year).value("2")
    page.item(:current_month).value("1")
    page.item(:current_day).value("5")
    page.item(:mayor).value("てすと市長")
    page.item(:zip).value("〒101-0032")
    page.item(:address).value("東京都 千代田区\nほげほげ\nふがふがビル2F")
    page.item(:phone_number).value("090-1111-2222")

    page.item(:name_kana).value("イモ　チクワ")
    page.item(:name).value("いも　ちくわ")
    page.item(:my_number).value("123456789012")
    page.item(:man).value("〇")
    page.item(:woman).value("")

    page.item(:year_meiji).value("")
    page.item(:year_taisyo).value("")
    page.item(:year_syowa).value("")
    page.item(:year_heisei).value("〇")
    page.item(:year_reiwa).value("")
    page.item(:birth_year).value("1")
    page.item(:birth_month).value("2")
    page.item(:birth_day).value("12")

    page.item(:donation_year).value("1")
    page.item(:donation_month).value("12")
    page.item(:donation_day).value("31")
    page.item(:donation_amount).value('\10,000')

    page.item(:check_one).value("\u2713")
    page.item(:check_two).value("\u2713")
  end

  # PDFダウンロード
  stat = File::stat(file_path)
  send_file(file_path, :filename => file_name, :length => stat.size, :type => 'application/octet-stream')
end
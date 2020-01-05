require 'sinatra'
require 'sinatra/reloader'
require 'thinreports'
require 'date'

# index.htmlを表示
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# PDFをダウンロードするルーティング
post '/download_pdf' do

  file_name = Time.now.strftime("%Y%m%d%H%M%S") + '_onestop.pdf'
  file_path = 'output/' + file_name

  date = Date.today
  current_year = date.strftime("%Y").to_i - 2018
  current_month = date.strftime("%-m")
  current_day = date.strftime("%-d")

  # PDF生成
  report = Thinreports::Report.new layout: 'tlfs/onestop.tlf'
  report.start_new_page

  report.page.item(:top_current_year).value(current_year)
  report.page.item(:current_year).value(current_year)
  report.page.item(:current_month).value(current_month)
  report.page.item(:current_day).value(current_day)
  report.page.item(:mayor).value(params[:mayor])
  report.page.item(:zip).value("〒" + params[:zip])
  report.page.item(:address).value(params[:address])
  report.page.item(:phone_number).value(params[:phone_number])
  report.page.item(:name_kana).value(params[:name_kana])
  report.page.item(:name).value(params[:name])
  report.page.item(:my_number).value(params[:my_number])
  if "man" == params[:sex] then
    report.page.item(:man).value("〇")
  elsif "woman" == params[:sex] then
    report.page.item(:woman).value("")
  end

  report.page.item(:year_meiji).value("")
  report.page.item(:year_taisyo).value("")
  report.page.item(:year_syowa).value("")
  report.page.item(:year_heisei).value("〇")
  report.page.item(:year_reiwa).value("")
  report.page.item(:birth_year).value("1")
  report.page.item(:birth_month).value("2")
  report.page.item(:birth_day).value("12")

  report.page.item(:donation_year).value("1")
  report.page.item(:donation_month).value("12")
  report.page.item(:donation_day).value("31")
  report.page.item(:donation_amount).value('\10,000')

  if "yes" == params[:check_one] then
    report.page.item(:check_one).value("\u2713")
  end
  if "yes" == params[:check_two] then
    report.page.item(:check_two).value("\u2713")
  end

  # PDF生成
  report.generate filename: file_path

  # PDFダウンロード
  stat = File::stat(file_path)
  send_file(file_path, :filename => file_name, :length => stat.size, :type => 'application/octet-stream')
end
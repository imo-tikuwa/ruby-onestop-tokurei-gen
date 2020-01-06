require 'sinatra'
require 'sinatra/reloader'
require 'thinreports'
require 'date'
require 'wareki'

# index.htmlを表示
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# PDFをダウンロードするルーティング
post '/' do

  file_name = Time.now.strftime("%Y%m%d%H%M%S") + '_onestop.pdf'
  file_path = 'output/' + file_name

  # 生年月日
  birth_date = Date.parse(params[:birth_date])
  birth_date_gengo = birth_date.strftime("%Je")
  birth_year = birth_date.strftime("%Jg")
  birth_month = birth_date.strftime("%-m")
  birth_day = birth_date.strftime("%-d")

  # 出力年月日
  output_date = Date.parse(params[:output_date])
  output_year = output_date.strftime("%Jg")
  output_month = output_date.strftime("%-m")
  output_day = output_date.strftime("%-d")

  # 寄附年月日
  donation_date = Date.parse(params[:donation_date])
  donation_year = donation_date.strftime("%Jg")
  donation_month = donation_date.strftime("%-m")
  donation_day = donation_date.strftime("%-d")

  # PDF生成
  report = Thinreports::Report.new layout: 'tlfs/onestop.tlf'
  report.start_new_page

  # tlfにフォームの入力内容を埋め込み
  report.page.item(:top_current_year).value(output_year)
  report.page.item(:current_year).value(output_year)
  report.page.item(:current_month).value(output_month)
  report.page.item(:current_day).value(output_day)
  report.page.item(:mayor).value(params[:mayor])
  report.page.item(:zip).value("〒" + params[:zip])
  report.page.item(:address).value(params[:address])
  report.page.item(:phone_number).value(params[:phone_number])
  report.page.item(:name_kana).value(params[:name_kana])
  report.page.item(:name).value(params[:name])
  report.page.item(:my_number).value(params[:my_number])
  case params[:sex]
  when 'man' then
    report.page.item(:man).value("〇")
  when 'woman' then
    report.page.item(:woman).value("〇")
  end
  case birth_date_gengo
  when '明治' then
    report.page.item(:year_meiji).value("〇")
  when '大正' then
    report.page.item(:year_taisyo).value("〇")
  when '昭和' then
    report.page.item(:year_syowa).value("〇")
  when '平成' then
    report.page.item(:year_heisei).value("〇")
  when '令和' then
    report.page.item(:year_reiwa).value("〇")
  end
  report.page.item(:birth_year).value(birth_year)
  report.page.item(:birth_month).value(birth_month)
  report.page.item(:birth_day).value(birth_day)
  report.page.item(:donation_year).value(donation_year)
  report.page.item(:donation_month).value(donation_month)
  report.page.item(:donation_day).value(donation_day)
  report.page.item(:donation_amount).value(number_format(params[:donation_amount]))
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

# カンマ区切りの数字文字列を返す
def number_format(num_string)
  '\\' + num_string.reverse.scan(/\d{3}|.+/).join(",").reverse
end
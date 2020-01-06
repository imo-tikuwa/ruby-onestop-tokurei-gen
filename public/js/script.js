$(function () {
  $('#birth_date, #output_date, #donation_date').datetimepicker({
    format: 'YYYY/MM/DD',
    locale: 'ja'
  });

  // 生年月日に初期値をセット
  if ($('#birth_date').val() == '') {
    $('#birth_date').val(moment('1989-01-01').format("YYYY/MM/DD"));
  }
  // 出力年月日、寄附年月日に現在日をセット
  if ($('#output_date').val() == '') {
    $('#output_date').val(moment().format("YYYY/MM/DD"));
  }
  if ($('#donation_date').val() == '') {
    $('#donation_date').val(moment().format("YYYY/MM/DD"));
  }
});
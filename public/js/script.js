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

  // テストデータで埋めるボタンの処理
  $("#test").on("click", function(){
    $("form").find("input[type='text'], textarea").each(function(input_index, input_item){
      let $input = $(input_item);
      $input.val($input.attr('placeholder'));
    });
    $("#radio_1").trigger('click');
    $("#check_one_0, #check_two_0").prop('checked', true);
  });
});
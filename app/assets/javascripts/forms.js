$(document).ready(function() {
	$('a.layout_item').click(function() {
		var value = $(this).attr('id');	
		$('a.layout_item img').removeClass('selected');
		$(this).children('img').addClass('selected')
		$('input#page_layout').val(value);
		return false;
	})

})

function showPeriodAndFrequency(value){
  switch (value) {
      case 'Daily':
          $('#period').html('day');
          $('#frequency').show();
					$('#end_date').show();
          break;
      case 'Weekly':
          $('#period').html('week');
          $('#frequency').show();
					$('#end_date').show();
          break;
      case 'Monthly':
          $('#period').html('month');
          $('#frequency').show();
					$('#end_date').show();
          break;
      case 'Yearly':
          $('#period').html('year');
          $('#frequency').show();
					$('#end_date').show();
          break;
      case 'Monday':
          $('#period_other').html('Monday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Tuesday':
          $('#period_other').html('Tuesday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Wednesday':
          $('#period_other').html('Wednesday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Thursday':
          $('#period_other').html('Thursday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Friday':
          $('#period_other').html('Friday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Saturday':
          $('#period_other').html('Saturday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
      case 'Sunday':
          $('#period_other').html('Sunday in the month');
          $('#position').show();
					$('#end_date').show();
          break;
          
      default:
          $('#frequency').hide();
					$('#position').hide();
					$('#end_date').hide();
					
  }      
}
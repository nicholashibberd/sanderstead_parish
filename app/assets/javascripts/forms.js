$(document).ready(function() {
	$('a.layout_item').click(function() {
		var value = $(this).attr('id');	
		$('a.layout_item img').removeClass('selected');
		$(this).children('img').addClass('selected')
		$('input#page_layout').val(value);
		return false;
	})
})
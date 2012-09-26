$(document).ready(function() {		

		if ($('#calendar').length) {
	    // fix sub nav on scroll
	    var $win = $(window),
	        $headings = $('table#table_headings'),
				  headingsTop = $headings.length && $headings.offset().top,
	        isFixed = 0
			
	    processScroll()
		
	    $win.on('scroll', processScroll)
		}

    function processScroll() {
      var scrollTop = $win.scrollTop()
      if (scrollTop >= headingsTop && !isFixed) {
        isFixed = 1
        $headings.addClass('fixed')
      } else if (scrollTop <= headingsTop && isFixed) {
        isFixed = 0
        $headings.removeClass('fixed')
      }
    }

  })
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $ ->
# 	$(".import").click ->
# 		$(".import-area").toggle()
$ ->
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next > a').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
				$('.pagination').text("Fetching more records ...")
				$.getScript(url)
			$(window).scroll
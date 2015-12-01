$(document).ready(function() {
	$('#search-form').submit(function(e) {
		e.preventDefault();
		var searchString = $('#search').val();

		$.getScript('/products?search=' + searchString);
	})
});
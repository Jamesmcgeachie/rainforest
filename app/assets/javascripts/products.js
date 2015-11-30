$(document).ready(function() {
	$('#search-form').submit(function() {
		event.preventDefault();
		var searchString = $('#search').val();

		$.getScript('/products?search=' + searchString);
	})
});
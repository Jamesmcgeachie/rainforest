$(document).ready(function() {
	$('#search-form').submit(function() {
		event.preventDefault();
		var searchString = $('#search').val();

		$.get('/products?search=' + searchString)
		.done(function(data){
			console.log(data);
			$('#products').html(data);
		})
	})
});
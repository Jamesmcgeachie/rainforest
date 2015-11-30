$(document).ready(function() {
	$('#search-form').submit(function() {
		event.preventDefault();
		var searchString = $('#search').val();

		$.ajax({
			url: '/products?search=' + searchString,
			type: 'GET',
			dataType: 'html'
		}).done(function(data){
			$('#products').html(data);
		})
	})
});
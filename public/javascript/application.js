$(function() {
	$("#load_teams").on('click', function() {
/*		$.ajax({
			url: '/teams.json',
			method: 'GET',
			dataType: 'json',
			success: function(data) {

			},
			failure: function(data) {
				alert("This failed. You suck.");
			}
		});
*/
		$.getJSON('/teams.json', function(data) {
			$.each(data, function(index, team) {
				alert(team.city + " " + team.name);
			});
		});
	});	
});

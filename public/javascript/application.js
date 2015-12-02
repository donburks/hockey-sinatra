$(function() {
	var handlers = {
		container: $("#canucks").find('tbody'),
		addPlayer: function(index, player) {
			var tr = $("<tr>").appendTo(handlers.container);
			$("<td>").text(player.name).appendTo(tr);
			$("<td>").text(player.position).appendTo(tr);
			$("<td>").text(player.weight).appendTo(tr);
		},
		receivePlayers: function(players) {
			$.each(players, handlers.addPlayer);
		},
		getPlayers: function() {
			handlers.container.empty();
			$.getJSON("/players", handlers.receivePlayers);
		}
	};

	$("#load_players").on('click', handlers.getPlayers);
	$("#new_player").on('click', function() {
		var num = $("#jersey").val();
		var pos = $("#position").val();
		var weight = $("#weight").val();
		var player = {name: num, position: pos, weight: weight};
		
		$.post("/new_player", player, function(data) {
			if (data.result) {
				handlers.addPlayer(0, player);	
			} else {
				alert("Unable to create player.");
			}
		}, 'json');
	});	
});

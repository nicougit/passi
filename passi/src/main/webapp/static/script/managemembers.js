var showToast = function(target, message) {
	if ($(target).queue().length > 0) {
		return;
	}
	$(target).text(message);
	$(target).fadeIn(1000).delay(2000).fadeOut(1000);
}

var getGroupUsers = function(id) {
	$.get('/passi/groupInfoUsers?groupID=' + id, function(data) {
		var memberRows = '';
		var supervisorRows = '';
		if (data.users.length === 0) {
			$('#group-users-table').addClass('hidden');
		} else {
			$('#group-users-table').removeClass('hidden');
		}
		for (var i = 0; i < data.users.length; i++) {
			memberRows += renderMemberRow(data.users[i], data.group.groupID);
		}
		
		for (var i = 0; i < data.group.instructors.length; i++) {
			supervisorRows += renderMemberRow(data.group.instructors[i], data.group.groupID);
		}
		
		$('#group-users-info').html(renderGroupInfo(data.group, data.users.length));;
		$('#group-users-tbody').html(memberRows);
		$('#group-supervisors-tbody').html(supervisorRows);
		$('#group-supervisors-table').removeClass('hidden');
		$('#add-supervisor-btn').val(id);
		selectTab('users');
	});
}

var addSupervisor = function(groupID) {
	var username = $('#supervisorusername').val().trim();
	if (username.length < 3) { 
		showToast('#errortoast', 'Liian lyhyt käyttäjänimi');
		return;
	}
	$.get('/passi/addGroupSupervisor?supervisorUsername=' + username + '&groupID=' + groupID, function(data) {
		if (data.status === true) {
			$('#supervisorusername').val('');
			showToast('#successtoast', 'Ohjaaja lisätty ryhmään!');
			getGroupUsers(groupID);
		} else {
			showToast('#errortoast', 'Ohjaajaa ei löytynyt!')
		}
	});
}

var renderMemberRow = function(user, groupID) {
	var memberFullname = user.firstname + ' ' + user.lastname;
	var deleteMemberButton = '<button onclick="confirmMemberRemoval(' + user.userID + ', ' + groupID + ', \'' + memberFullname +'\'); this.blur();" type="button" class="btn btn-secondary" title="Poista jäsen ryhmästä"><span class="glyphicon glyphicon-remove"></span></button>';
	return '<tr><td>' + memberFullname + '</td><td class="text-center">' + deleteMemberButton + '</td></tr>';
}

var confirmMemberRemoval = function(userID, groupID, memberFullname) {
	var confirmationMessage = 'Haluatko varmasti poistaa jäsenen ' + memberFullname + ' ryhmästä?';
	if (confirm(confirmationMessage)) {
		deleteGroupMember(userID, groupID);
	}
}

var deleteGroupMember = function(userID, groupID) {
	var params = 'userID=' + userID + '&groupID=' + groupID;
	$.get('/passi/delGroupMember?' + params, function(data) {
		if (data.status === true) {
			showToast('#successtoast', 'Jäsen poistettu onnistuneesti!');
			getGroupUsers(groupID);
		} else {
			showToast('#errortoast', 'Jäsenen poistossa tapahtui virhe!');
		}
	});
}

var renderGroupInfo = function(group, studentCount) {
	var groupName = group.groupName;
	if (studentCount === 0) {
		return '<strong>Ryhmän nimi ja tunnus:</strong><br/>' + groupName + '<br/><br/>Ryhmässä ei ole vielä yhtään opiskelijaa.';
	}
	var studentWord = 'opiskelijaa';
	if (studentCount === 1) {
		studentWord = 'opiskelija';
	}
	return '<strong>Ryhmän nimi ja tunnus:</strong><br/>' + groupName + '<br /><br />Ryhmässä on yhteensä <strong>' + studentCount + '</strong> ' + studentWord + '.';
}
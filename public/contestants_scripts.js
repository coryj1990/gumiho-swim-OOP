window.addEventListener('load', function(){

	//need to cancel the page reload on form submission
	var form = document.querySelector('form');
	form.addEventListener('submit', function(e){

		var entryformParams = new FormData(form);

		e.preventDefault()

		var successwindow = document.getElementById('successalert');

		var contestantRequest = new XMLHttpRequest();

		contestantRequest.open('post', '/swimmers/new');
		contestantRequest.send(entryformParams);


		contestantRequest.addEventListener('load', function(){

			successwindow.style.display = 'block';
			successwindow.addEventListener('click', function(){
				hideWindow();
			})
			function hideWindow() {
				successwindow.style.display = 'none';
			}

			form.reset();
		});

		contestantRequest.addEventListener('error', function(){
			alert('Something went wrong.')
		});

	})


})
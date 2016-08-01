window.addEventListener('load', function() {
	//objects to click (header for each event)
	var eventheads = document.getElementsByClassName('winners__eventhead');

	//objects whose view will be changed (all the individual placers)
	var medalists = document.querySelectorAll('ol.winners__list')

	//symbols that rotate when you hover over the header
	var symbol = document.getElementsByClassName('winners__symbol');

	//hides all of the medalists to start
	for (var i = medalists.length - 1; i >= 0; i--) {
		medalists[i].style.height = "0px";
	}

	//total number of events
	var eventnum = eventheads.length;

	//function to generate an event listener on each header
	//
	//x is the position of a header in eventhead and the corresponding list of medalists
	function makeEventListener(x){
<<<<<<< HEAD
		eventheads[x].addEventListener('mouseup', function(){
			//if the list is hidden, it will be displayed
			if (medalists[x].style.height == "0px") {
				medalists[x].style.height = 'auto';
				symbol[x].style.transform = "rotate(45deg)";
				symbol[x].style.animationDuration = "0s"
=======
		eventheads[x].addEventListener('click', function(){
			//if the list is hidden, it will be displayed
			if (medalists[x].style.height == "0px") {
				medalists[x].style.height = 'auto';
				medalists[x].style.animationName = 'drop';
				symbol[x].style.transform = "rotate(45deg)";
				symbol[x].style.animationDuration = "0s";
>>>>>>> eb6de99ef1926fca06ff84c16a65bd6d5ad5fa76
			}
			//if the list is not hidden, clicking on the header will hide it again
			else {
				medalists[x].style.height = '0px';
				symbol[x].style.transform = "rotate(0deg)";
<<<<<<< HEAD
				symbol[x].style.animationDuration = "0.8s"
=======
				symbol[x].style.animationDuration = "0.8s";
>>>>>>> eb6de99ef1926fca06ff84c16a65bd6d5ad5fa76
			}
		})
	}

	//create event listeners for the total number of headers
	for (var i = 0; i < eventnum; i++) {
		makeEventListener(i);
	}

});
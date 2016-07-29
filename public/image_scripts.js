	var currentImageIndex = -1;
	var maxImageIndex = 10;
	var changeInterval = 1500;

	var images = [
  {  
    id: "00",
    src: "Pools/Best-Collegiate-Competition-Pools.jpg",
    facilityName: "Collegeranker\'s 10 Best",
    schoolName: "Collegiate Swimming Pools",
    link: "http://www.collegeranker.com/features/best-collegiate-competition-swimming-pools/"
  },
  { 
    id: "01",
    src: "Pools/Denison-University-Trumbull-Aquatic.jpg",
    facilityName: "Trumbull Aquatic Center",
    schoolName:"Denison University",
    link: "http://denisonbigred.com/facilities/trumbull_aquatics_center"
  },
  { 
    id: "02",
    src: "Pools/Princeton-University-Denunzio-Pool.jpg",
    facilityName: "Denunzio Aquatic",
    schoolName:"Princeton University",
    link: "http://www.princeton.edu/~gpaczkow/"
  },
  { 
    id: "03",
    src: "Pools/Gabrielsen-Pool-University-of-Georgia.jpg",
    facilityName: "Gabrielsen Natatorium",
    schoolName:"University of Georgia",
    link: "http://www.georgiadogs.com/facilities/gabrielsen-natatorium.html"
  },
  { 
    id: "04",
    src: "Pools/Kiphuth-Exhibition-Pool-Yale-University.jpg",
    facilityName: "Robert Kiphuth Memorial Exhibition Pool",
    schoolName:"Yale University",
    link: "http://www.yalebulldogs.com/information/facilities/payne_whitney_gym/pools"
  },
  { 
    id: "05",
    src: "Pools/Avery-Aquatic-Stanford-University.jpg",
    facilityName: "Avery Aquatic Center",
    schoolName:"Stanford University",
    link: "http://cardinalrec.stanford.edu/aquatics/avery-aquatic-center/"
  },
  { 
    id: "06",
    src: "Pools/Freeman-Aquatic-University-of-Minnesota.jpg",
    facilityName: "Freeman Aquatic Center",
    schoolName:"University of Minnesota",
    link: "http://www.gophersports.com/facilities/acquatic-center.html"
  },
  { 
    id: "07",
    src: "Pools/McCorkle-Aquatic-Ohio-State.jpg",
    facilityName: "Mccorkle Aquatic Pavilion",
    schoolName:"The Ohio State University",
    link: "http://www.ohiostatebuckeyes.com/facilities/mccorkle-pavilion.html"
  },
  { 
    id: "08",
    src: "Pools/IUPUI-Natatorium-Indiana-and-Purdue.jpg",
    facilityName: "IU Natatorium – Indianapolis (IUPUI)",
    schoolName:"Indiana University – Purdue University",
    link: "https://www.iunat.iupui.edu/"
  },
  { 
    id: "09",
    src: "Pools/Jamail-Texas-at-Austin.jpg",
    facilityName: "Lee and Joe Jamail Texas Swimming Center",
    schoolName:"University of Texas at Austin",
    link: "http://www.tsc.utexas.edu/"
  },
  { 
    id: "10",
    src: "Pools/McAuley-Aquatic-Center-Georgia-Tech.jpg",
    facilityName: "Herb McAuley Aquatic Center",
    schoolName:"Georgia Tech",
    link: "http://www.crc.gatech.edu/aquatics/content/21/aquatic-center-facts"
  }]
 

window.addEventListener("load", function() {
		maxImageIndex = images.length;
        currentImageIndex = 0;
        var imgSrc = document.getElementById("img");
		var facilityName = document.getElementById("facilityName");
		var schoolName = document.getElementById("schoolName");
  	var changeImgAndText = function() {
  		if (currentImageIndex != maxImageIndex) {
  			currentImageIndex ++;
  		} else {
  			currentImageIndex = 0;
  		}
		switch (currentImageIndex) {
			case 0:
				imgSrc.src = images[0].src;
				facilityName.innerHTML = images[0].facilityName;
				schoolName.innerHTML = images[0].schoolName;
				break;
			case 1:
				imgSrc.src = images[1].src;
				facilityName.innerHTML = images[1].facilityName;
				schoolName.innerHTML = images[1].schoolName;
				break;
			case 2:
				imgSrc.src = images[2].src;
				facilityName.innerHTML = images[2].facilityName;
				schoolName.innerHTML = images[2].schoolName;
				break;
			case 3:
				imgSrc.src = images[3].src;
				facilityName.innerHTML = images[3].facilityName;
				schoolName.innerHTML = images[3].schoolName;
				break;
			case 4:
				imgSrc.src = images[4].src;
				facilityName.innerHTML = images[4].facilityName;
				schoolName.innerHTML = images[4].schoolName;
				break;
			case 5:
				imgSrc.src = images[5].src;
				facilityName.innerHTML = images[5].facilityName;
				schoolName.innerHTML = images[5].schoolName;
				break;
			case 6:
				imgSrc.src = images[6].src;
				facilityName.innerHTML = images[6].facilityName;
				schoolName.innerHTML = images[6].schoolName;
				break;
			case 7:
				imgSrc.src = images[7].src;
				facilityName.innerHTML = images[7].facilityName;
				schoolName.innerHTML = images[7].schoolName;
				break;
			case 8:
				imgSrc.src = images[8].src;
				facilityName.innerHTML = images[8].facilityName;
				schoolName.innerHTML = images[8].schoolName;
				break;
			case 9:
				imgSrc.src = images[9].src;
				facilityName.innerHTML = images[9].facilityName;
				schoolName.innerHTML = images[9].schoolName;
				break;
			case 10:
				imgSrc.src = images[10].src;
				facilityName.innerHTML = images[10].facilityName;
				schoolName.innerHTML = images[10].schoolName;
				break;
			default: 
				imgSrc.src = images[0].src;
				facilityName.innerHTML = images[0].facilityName;
				schoolName.innerHTML = images[0].schoolName;
  		}
	}
		setInterval(changeImgAndText, changeInterval);
});


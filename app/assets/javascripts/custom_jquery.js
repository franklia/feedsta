$(document).ready(function() {

	// Set .pictures-wrapper height onload
	var width = $('.pictures-wrapper').width();
    $('.pictures-wrapper').css({ height : width + "px" }); 

    // Set .pictures-wrapper height on resizing of browser
    $(window).resize(function(){
    	var width = $('.pictures-wrapper').width();
    	$('.pictures-wrapper').css({ height : width + "px" }); 
    });
});

// 
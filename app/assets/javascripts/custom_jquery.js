$(document).ready(function() {

	// Set .pictures-wrapper height onload
	var width = $('.photo-wrapper').width();
    $('.photo-wrapper').css({ height : width + "px" }); 

    // Set .pictures-wrapper height on resizing of browser
    $(window).resize(function(){
    	var width = $('.photo-wrapper').width();
    	$('.photo-wrapper').css({ height : width + "px" }); 
    });

    $( function() {
        $( "#sortable" ).sortable({
          revert: true
        });
        $( "#draggable" ).draggable({
          connectToSortable: "#sortable",
          helper: "clone",
          revert: "invalid"
        });
    });
});

// 
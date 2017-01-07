$(document).on('turbolinks:load', function() {

	// Set .pictures-wrapper height onload
	var width = $('.photo-wrapper').width();
  $('.photo-wrapper').css({ height : width + "px" }); 

  // Set .pictures-wrapper height on resizing of browser
  $(window).resize(function(){
  	var width = $('.photo-wrapper').width();
  	$('.photo-wrapper').css({ height : width + "px" }); 
  });

  // Drag and drop for photos in feed
  $( function() {
      $("#sortable").sortable({
        revert: true
      });
      // $( "#draggable" ).draggable({
      //   connectToSortable: "#sortable",
      //   helper: "clone",
      //   revert: "invalid"
      // });
  });

  // 
  $( "#save-photo-order" ).click(function(){
      var sorted = $("#sortable").sortable( "serialize", { key: "position" } );
      console.log(sorted);
      $.ajax({
        type  : 'POST',
        url   : '',
        data  : $('.sortable').sortable('serialize') 
      });
  });

});
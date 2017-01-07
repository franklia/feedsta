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
        // element slides into place smoothly once dropped
        revert: true,
        // changes button text to "Save Photo Order"
        update: function( event, ui ) {
          $("#save-photo-order").text("Save Photo Order")
        } 
      });
  });

  // Saves order of photos
  $("#save-photo-order").click(function(){
      var sorted = $("#sortable").sortable( "serialize");
      $.ajax({
        type  : 'POST',
        url   : '/photos/save_order',
        data  : sorted 
      });
      $("#save-photo-order").text("Saved"); // Changes button text to "Saved"
  });

});
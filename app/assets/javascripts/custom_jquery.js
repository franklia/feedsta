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

  // Search by hashtag on followers page
  $("#find-followers").click(function(){
    
      $("#follower-list").empty(); // empty results div so new search does not add on top

      var hashtag = $("#hashtag-text").val();

      $.ajax({
        type: 'POST',
        url: '/users_followed/suggest',
        data: {data: hashtag},
        success: function(data, textStatus, jQxhr){
          $("#follower-list").append(data)
        }
      });
  });

});
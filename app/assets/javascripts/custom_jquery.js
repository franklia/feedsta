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

  $(".spinner").hide(); // Hide spinner for function below

  // Search by hashtag on followers page
  $("#find-followers").click(function(){

      $("#follower-list").empty(); // empty results div so new search does not add on top
      $(".spinner").show();
      var hashtag = $("#hashtag-text").val();

      $.ajax({
        type: 'POST',
        url: '/users_followed/suggest',
        data: {data: hashtag},
        success: function(data, textStatus, jQxhr){
          $(".spinner").hide();
          $("#follower-list").append(data)
        }
      });
  });

  // Request to unfollow
  $(".unfollow").click(function(){
      var token = $("#account_token").val();;
      var user_id = this.id;
      var url = "https://api.instagram.com/v1/users/" + user_id + "/relationship?access_token=" + token + "&action=follow";
      console.log(url);
      $("#" + user_id).hide(); // Hide button for function below
      $("#spinner-" + user_id).show();

      $.ajax({
        type: 'POST',
        url: url,
        success: function(data, textStatus, jQxhr){
          $("#spinner-" + user_id).hide();

        }
      });
  });

});
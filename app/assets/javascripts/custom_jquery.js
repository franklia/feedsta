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
      var user_id = this.id;
      $("#" + user_id).hide(); 
      $("#spinner-" + user_id).show();

      $.ajax({
        type: 'POST',
        url: '/users_followed/insta_unfollow',
        data: {user_id: user_id},
        success: function(data, textStatus, jQxhr){
          console.log(data.meta);
          if (data.meta['code'] == "200"){
            $("#spinner-" + user_id).hide();
            $("#" + user_id).removeClass("btn-success").addClass("btn-primary").text("Unfollowed").show();
          } else {
            $("#spinner-" + user_id).hide();
            $("#error-msg").removeClass("hidden");
          }
          
        }
      });
  });

  // Request to follow
  // $(".follow").click(function(){
  //     var user_id = this.id;
  //     $("#" + user_id).hide(); 
  //     $("#spinner-" + user_id).show();

  //     $.ajax({
  //       type: 'POST',
  //       url: '/users_followed/insta_follow',
  //       data: {user_id: user_id},
  //       success: function(data, textStatus, jQxhr){
  //         console.log(data.meta);
  //         if (data.meta['code'] == "200"){
  //           $("#spinner-" + user_id).hide();
  //           $("#" + user_id).removeClass("btn-primary follow").addClass("btn-success unfollow").show();
  //         } else {
  //           $("#spinner-" + user_id).hide();
  //           $("#error-msg").removeClass("hidden");
  //         }
          
  //       }
  //     });
  // });

});
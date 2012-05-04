function sendVote(vote) {
  $.ajax({
    url: "/users/0/votes/" + vote,
    success: function(output_string) {
      var votes = output_string.split("\n").map(function(str) {
        return str;
      });
      $("#up").replaceWith("<span id=\"up\" class=\"thumb\">" + votes[1].split(" ").pop() + "</span>");
      $("#dn").replaceWith("<span id=\"dn\" class=\"thumb\">" + votes[2].split(" ").pop() + "</span>");
      $("#msg").html("<span id=\"#msg\">" + votes[4] + "</span>");
    }
  });
}

var vote = function(rating, artifactId) {
  return function() {
    sendVote(artifactId + "+" + rating);

    $("#msg").dialog({
      resizable: false,
      height: 190,
      modal: true,
      title: "Ya sure?",
      buttons: {
        "Change It": function() {
          sendVote("C");
          $( this ).dialog( "close" );
        },
        "Keep It": function() {
          $( this ).dialog( "close" );
        }
      }
    });
  };
};
var vote = function(rating, artifactId) {
  return function() {
    $.ajax({
      url: "/users/0/votes/" + artifactId + "+" + rating,
      success: function(output_string) {
        var votes = output_string.split("\n").map(function(str) {
          return str.split(" ").pop();
        });
        $("#up").replaceWith("<span id=\"#up\" class=\"thumb\">" + votes[0] + "</span>");
        $("#dn").replaceWith("<span id=\"#dn\" class=\"thumb\">" + votes[1] + "</span>");
      }
    });
  };
};
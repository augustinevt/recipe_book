// FRONTEND
$(function() {

  submitIngredients = function() {
    document.getElementById("recipe_form").submit();
  };

  submitTags = function() {
    document.getElementById("recipe_form").submit();
  };


  $('#search-form').submit(function(e) {
    if ( $('#search').val() === "ants" ) {
      e.preventDefault()
      $('.antz').show();
      console.log('yes ants')

    }
    console.log('no ants')
  });

  antShow = function() {
    $('antz').show();
  };
});

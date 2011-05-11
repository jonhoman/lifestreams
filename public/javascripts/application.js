// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('a#new-feed-link').attr('href', '#');

  $('a#new-feed-link').click(function() {
    $('#new-feed').show('slow');
  });
  
});

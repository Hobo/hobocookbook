// This file is included in all sites and subsites.  This is a
// manifest file that'll be compiled into including all the files
// listed below.  Add new JavaScript/Coffee code in separate files in
// the application directory and they'll automatically be included.
// It's not advisable to add code directly here, but if you do, it'll
// appear at the bottom of the the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require hobo_rapid
//= require hobo_jquery
//= require hobo_bootstrap_ui
//= require_tree ./application

$(document).ready(function() {
   var $section;
   if(($section=$("#gallery-section")).length>0) {
     var items = $section.find("h3").map(function() { return $(this).next().addBack(); });
     items.each(function() {
       $("#gallery-carousel .carousel-inner").append(
         $("<div class='item'></div>").append($(this)));
     });
     $("#gallery-carousel div.item:first").addClass("active");
     $("#gallery-carousel").carousel({interval: 10000});
     $("#gallery-section .document-title").wrap("<a href='/manual/gallery'></a>");
  }
});

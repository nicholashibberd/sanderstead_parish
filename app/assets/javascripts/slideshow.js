function Slideshow(element) {
	this.element = element;
	this.remaining_images = this.load_images();
	
}

Slideshow.prototype.load_images = function() {
	this.element.find('div.load-lazy').each(function(i, el){
    var element = $(el);

    var imgSrc     = element.attr('data-src');
    var imgElement = $('<img />');

    /* create img element */

    var image = new Image();
    image.onload = function() {
      imgElement.attr('src', imgSrc);
      imgElement.attr('class', 'hide');
      element.replaceWith(imgElement);
    };
    /* pull the image path and set it here for the image */
    image.src = imgSrc;
  });

}

$(document).ready(function() {
	// if ($('.slideshow_widget').length) {
	// 	var slideshow = new Slideshow($('.slideshow_widget'))
	// }
})
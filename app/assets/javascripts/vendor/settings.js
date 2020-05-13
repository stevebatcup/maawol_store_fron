(function ($) {
    "use strict";

	var parameters = [];

	var settings_block = '<div class="block-settings-wrapper">'+
							'<div id="block_settings" class="block_settings">'+
								'<section>'+
									'<h3>HEADER STYLE</h3>'+
									'<ul>'+
										'<li class="header-image"><a href="image.html">Single Image</a></li>'+
										'<li class="header-slide"><a href="slide.html">Image Slideshow</a></li>'+
										'<li class="header-video"><a href="video.html">Video Background</a></li>'+
									'</ul>'+
									'<hr>'+
									'<h3>COLORS</h3>'+
									'<span class="blue" 		title="Blue" 		data-color="#16b6ea" />'+
									'<span class="green" 		title="Green" 		data-color="#24b7a4" />'+
									'<span class="red" 			title="Red" 		data-color="#ff2c55" />'+
									'<span class="turquoise" 	title="Turquoise" 	data-color="#46cad7" />'+
									'<span class="purple" 		title="Purple" 		data-color="#ca3378" />'+
									'<span class="orange" 		title="Orange" 		data-color="#ee8f67" />'+
									'<span class="yellow" 		title="Yellow" 		data-color="#ffbe00" />'+
									'<span class="grey" 		title="Grey" 		data-color="#656d78" />'+
								'</section>'+
								'<a href="#" id="settings_close">Close</a>'+
							'</div>'+
						'</div>';

	//Init color buttons
	function initColor() {
		$(".block-settings-wrapper section span").on("click", function() {
			var cls = $(this).attr("class");

			//CSS
			$("link.colors").attr("href", "layout/colors/"+cls+".css");
		});
	}

	//Init open/close button	
	function initClose() {
		parameters.push("opened");

		$("#settings_close").on("click", function(e) {
			$("body").toggleClass("opened-settings");

			if (!$.cookies.get("opened")) {
				$.cookies.set("opened", "opened-settings");
			} else {
				$.cookies.del("opened");
			}

			e.preventDefault();	
		});
	}

	//Init cookies
	function initCookies() {
		for (var key in parameters) {
			if (parameters.hasOwnProperty(key)) {
				var name = parameters[key];
				var parameter = $.cookies.get(name);

				if (parameter) {
					$("body").addClass(parameter);
				}
			}
		}
	}

	//Init
	$("body").prepend(settings_block);
	initColor();	
	initClose();
	initCookies();

	//Activate header style
	var url = window.location.href;
	var ind = url.lastIndexOf("/");
	url = url.substr(ind+1);

	ind = url.indexOf(".");
	url = url.substr(0, ind);

	if (url==="") {url = "image";}

	var $page = $("li.header-"+url);

	$page.addClass("active");
	$page.append('<i class="fa fa-check"></i>');
	
})(jQuery);
//----MENU---//
$('.navbar .dropdown').hover(function() {
	$(this).addClass('extra-nav-class').find('.dropdown-menu').first().stop(true, true).delay(50).slideDown();
}, function() {
	var na = $(this)
	na.find('.dropdown-menu').first().stop(true, true).delay(100).slideUp('fast', function(){ na.removeClass('extra-nav-class') })
});

//MENU RESPONSIVE
 $(document).ready(function(){
$("#nav").tinyNav({
  active: 'selected', // String: Set the "active" class
  header: 'MENU +', // String: Specify text for "header" and show header instead of the active item
  label: '' // String: Sets the <label> text for the <select> (if not set, no label will be added)
});
});
 

//----HEADER---//
jQuery(window).scroll(function () {
  if (jQuery(document).scrollTop() == 0) {
    jQuery('.wowmenu').removeClass('tiny');
  } else {
    jQuery('.wowmenu').addClass('tiny');
  }
});


//----FOOTER TESTIMONIAL---//  
jQuery(document).ready(function ($) {
$('.textItem').quovolver();
  });


//////CONTACT FORM VALIDATION
jQuery(document).ready(function ($) {
	
	//if submit button is clicked
	$('#submit').click(function () {		
		
		//Get the data from all the fields
		var name = $('input[name=name]');
		var email = $('input[name=email]');
		var regx = /^([a-z0-9_\-\.])+\@([a-z0-9_\-\.])+\.([a-z]{2,4})$/i;
		var comment = $('textarea[name=comment]');
		var returnError = false;
		
		//Simple validation to make sure user entered something
		//Add your own error checking here with JS, but also do some error checking with PHP.
		//If error found, add hightlight class to the text field
		if (name.val()=='') {
			name.addClass('error');
			returnError = true;
		} else name.removeClass('error');
		
		if (email.val()=='') {
			email.addClass('error');
			returnError = true;
		} else email.removeClass('error');		
		
		if(!regx.test(email.val())){
          email.addClass('error');
          returnError = true;
		} else email.removeClass('error');
		
		
		if (comment.val()=='') {
			comment.addClass('error');
			returnError = true;
		} else comment.removeClass('error');
		
		// Highlight all error fields, then quit.
		if(returnError == true){
			return false;	
		}
		
		//organize the data
		
		var data = 'name=' + name.val() + '&email=' + email.val() + '&comment='  + encodeURIComponent(comment.val());

		//disabled all the text fields
		$('.text').attr('disabled','true');
		
		//show the loading sign
		$('.loading').show();
		
		//start the ajax
		$.ajax({
			//this is the php file that processes the data and sends email
			url: "contact.php",	
			
			//GET method is used
			type: "GET",

			//pass the data			
			data: data,		
			
			//Do not cache the page
			cache: false,
			
			//success
			success: function (html) {				
				//if contact.php returned 1/true (send mail success)
				if (html==1) {
				
					//show the success message
					$('.done').fadeIn('slow');
					
					$(".form").find('input[type=text], textarea').val("");
					
				//if contact.php returned 0/false (send mail failed)
				} else alert('Sorry, unexpected error. Please try again later.');				
			}		
		});
		
		//cancel the submit button default behaviours
		return false;
	});	
});	
  


  
  
//----TO TOP---//
jQuery(document).ready(function($){
	// hide #back-top first
	$("#back-top").hide();	
	// fade in #back-top
	$(function () {
		$(window).scroll(function () {
			if ($(this).scrollTop() > 600) {
				$('#back-top').fadeIn();
			} else {
				$('#back-top').fadeOut();
			}
		});
		// scroll body to 0px on click
		$('#back-top a').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});
	});
});



	//YUMMI LOADER
	var $body = $('body');
	$(window).load(function() {
		$body.toggleClass('on off');
		$('#trigger').click(function() {
			$body.toggleClass('on off');
			setTimeout(function() {
				$body.toggleClass('on off');
			}, 2000)
		});
	}); 
	
	  
//////----Placeholder for IE---////////
$(function() {
    // Invoke the plugin
    $('input, textarea').placeholder();
  });

//----ANIMATIONS---//
jQuery(document).ready(function($){

jQuery('.animated').appear();

    jQuery(document.body).on('appear', '.fade', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('anim-fade') });
    });
    jQuery(document.body).on('appear', '.slidea', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('anim-slide') });
    });
    jQuery(document.body).on('appear', '.hatch', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('anim-hatch') });
    });
    jQuery(document.body).on('appear', '.entrance', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('anim-entrance') });
    });
	jQuery(document.body).on('appear', '.fadeInUpNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInUp') });
    });
	jQuery(document.body).on('appear', '.fadeInDownNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInDown') });
    });
	jQuery(document.body).on('appear', '.fadeInLeftNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInLeft') });
    });
	jQuery(document.body).on('appear', '.fadeInRightNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInRight') });
    });
	
	
	jQuery(document.body).on('appear', '.fadeInUpBigNow', function() {
    jQuery(this).each(function(){ jQuery(this).addClass('fadeInUpBig') });
    });
	jQuery(document.body).on('appear', '.fadeInDownBigNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInDownBig') });
    });
	jQuery(document.body).on('appear', '.fadeInLeftBigNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInLeftBig') });
    });
	jQuery(document.body).on('appear', '.fadeInRightBigNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeInRightBig') });
    });
	
	jQuery(document.body).on('appear', '.fadeInNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('fadeIn') });
    });
	jQuery(document.body).on('appear', '.flashNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('flash') });
    });
	jQuery(document.body).on('appear', '.shakeNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('shake') });
    });
	jQuery(document.body).on('appear', '.bounceNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('bounce') });
    });
	jQuery(document.body).on('appear', '.tadaNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('tada') });
    });
	jQuery(document.body).on('appear', '.swingNow', function() {
        jQuery(this).each(function(){ jQuery(this).addClass('swing') });
    });
});
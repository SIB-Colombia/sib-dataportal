function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";
    document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = escape(name) + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return unescape(c.substring(nameEQ.length, c.length));
    }
    return null;
}

function readCookies() {
    var ca = document.cookie.split(';');
    alert(document.cookie);
    var total="";
    for (var i = 0; i < ca.length; i++) {
    	total=total+" "+ca[i];
    }
    return total;
}

function openWindow( url )
{
  window.open(url, '_blank');
  window.focus();
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

$(document).ready(function () {
(function($){
	jQuery.fn.jConfirmAction = function (options) {
		var theOptions = jQuery.extend ({
			question: "Are You Sure ?",
			yesAnswer: "Yes",
			cancelAnswer: "Cancel",
			url:""
		}, options);
		
		$( ".dialog-confirm" ).dialog( "option", "modal", true );
		
		if(typeof this.attr("class")!=='undefined'){
			return this.each (function () {
				$(this).bind('click', function(e) {
					var submitBtn = $(this);
					if(readCookie('GbifTermsAndConditions')===null){
						e.preventDefault();
	                    thisHref = $(this).attr('href');
	                    var btns = {};
	                    btns[theOptions.yesAnswer]=function() {  
	                            $( this ).dialog( "close" );                                    
	                            if (thisHref!=null){
	                            	createCookie('GbifTermsAndConditions', 'accepted', 1);
	                            	window.location = thisHref;
	                            }else{
	                            	createCookie('GbifTermsAndConditions', 'accepted', 1);
	                                submitBtn.click();
	                            }
	                    };
	                    
	                    btns[theOptions.cancelAnswer]=function() {                                                              
	                        $( this ).dialog( "close" ); 
	                	};
	                	
	                	var content='<p>'+theOptions.question+'</p>';
	                    if(typeof theOptions.checkboxText!=='undefined'){
	                            content='<p>'+'<input type="checkbox" id="cbox">'+theOptions.checkboxText+'<br/><br/>'+theOptions.question+'</p>';
	                    }
	                    
	                    
	                    
	                    
	                    $('#dialog-confirm').html(content);
	                    
	                    $('#dialog-confirm').dialog({
	                        resizable: false,
	                        modal: true,
	                        buttons: btns,
	                        show: {
	                            effect: "blind",
	                            duration: 1000
	                          },
	                          
	                        hide: {
	                              effect: "blind",
	                              duration: 1000
	                        }, 
	                        draggable: false,
	                        //dialogClass: 'main-dialog-class'
	                	});	
	                    
	                    $('a.newtab').bind('click', function(e) {
	                    	e.preventDefault();
	                    	nref = $(this).attr('href');
	                    	//console.log("open new tab");
	                    	window.open(this.href);
	                    });
	                    
					}
				});
				
			});
		}else{
			
			if(readCookie('GbifTermsAndConditions')===null){
				
				var sta=null;
				var btns = {};
                btns[theOptions.yesAnswer]=function() {  
                	sta=1;
                	$( this ).dialog( "close" );
                    createCookie('GbifTermsAndConditions', 'accepted', 1);
                    submitBtn.click();      
                };
                
                btns[theOptions.cancelAnswer]=function() {                                                              
                	$( this ).dialog( "close" ); 
            	};
            	
            	
            	var content='<p>'+theOptions.question+'</p>';
                if(typeof theOptions.checkboxText!=='undefined'){
                        content='<p>'+'<input type="checkbox" id="cbox">'+theOptions.checkboxText+'<br/><br/>'+theOptions.question+'</p>';
                }
                
                $('#dialog-confirm').html(content);
                $('#dialog-confirm').dialog({
                    resizable: false,
                    modal: true,
                    buttons: btns,
                    show: {
                    	effect:"blind",
                        duration: 1000
                      },
                      
                    hide: {
                    	effect:"blind",
                        duration: 1000
                    }, 
                    draggable: false,
                    close: function( event, ui ) {if(sta===null)window.location = theOptions.url;}
            	});
                $('a.newtab').bind('click', function(e) {
                	e.preventDefault();
                	nref = $(this).attr('href');
                	console.log(":D");
                	window.open(this.href);
                });
			}
			
		}
	};
	
	})(jQuery);
});



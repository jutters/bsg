/** Scroll To Function **/

$(document).ready(function() {
    
    $('a[href*=#]').bind('click', function(event) {
        event.preventDefault();
        var ziel = $(this).attr('href');
        $('html,body').animate({
            scrollTop: $(ziel).offset().top /** Reduce the Margin **/
        }, 500, function (){location.hash = ziel;});
    });
    return false;

    
});


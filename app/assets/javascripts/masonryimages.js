$(document).on('turbolinks:load', function() {
    var $grid = $('.js-masonry');
    $grid.masonry({
        itemSelector: '.proto-content',
        columnWidth: 280,
        gutter: 6,
        stagger: 6,
        percentPosition: true,
        visibleStyle: { transform: 'translateY(0)', opacity: 1 },
        hiddenStyle: { transform: 'translateY(100px)', opacity: 0 },
    });

    var msnry = $grid.data('masonry');

    $grid.infiniteScroll({
        path: 'a[rel=next]',
        append: '.proto-content',
        outlayer: msnry,
        scrollThreshold: 40,
        hideNav: '.pagination',
        history: false
    }, function( newElements ) {
      var $newElems = $( newElements ).css({ opacity: 0 });
      $newElems.imagesLoaded(function(){
        $newElems.animate({ opacity: 1 });
        $grid.masonry( 'appended', $newElems, true );
      });
    });
});

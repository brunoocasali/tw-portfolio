function getHashFilter() {
  var matches = location.hash.match(/#([^&]+)/i);
  var hashFilter = matches && matches[1];

  if (hashFilter == null) {
    return '*';
  } else if (hashFilter != '*') {
    return "." + (hashFilter && decodeURIComponent(hashFilter));
  } else {
    return '*';
  }
}

// init Isotope
var $grid = $('.grid');

// bind filter button click
var $filterButtonGroup = $('.links');
$filterButtonGroup.on('click', 'a', function() {
  var filterAttr = $(this).attr('data-filter');
  // set filter in hash
  location.hash = encodeURIComponent(filterAttr);
});

var isIsotopeInit = false;

function onHashchange() {
  var hashFilter = getHashFilter();
  if (!hashFilter && isIsotopeInit) {
    return;
  }
  isIsotopeInit = true;
  // filter isotope
  $grid.isotope({
    itemSelector: '.element-item',
    layoutMode: 'fitRows',
    filter: hashFilter
  });
  // set selected class on button
  if (hashFilter) {
    $filterButtonGroup.find('.is-checked').removeClass('is-checked');
    $filterButtonGroup.find('[data-filter="' + hashFilter + '"]').addClass('is-checked');
  }

  if (!$grid.data('isotope').filteredItems.length) {
    $('.empty-msg').removeClass('hide');
  } else {
    $('.empty-msg').addClass('hide');
  }
}

$(window).on('hashchange', onHashchange);

onHashchange();

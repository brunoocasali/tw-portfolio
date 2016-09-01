// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.old
//= require lemmon-slider
//= require fullpage
//= require isotope.pkgd.min
//= require default.min
//= require jquery.prettyPhoto

// external js: isotope.pkgd.js

function getHashFilter() {
  // get filter=filterName
  var matches = location.hash.match(/#([^&]+)/i);
  var hashFilter = matches && matches[1];

  console.log('entrou');
  console.log(hashFilter);

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

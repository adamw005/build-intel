
/* global $, Chartkick */
/* eslint-disable no-var, func-names, prefer-arrow-callback, jsx-a11y/href-no-hash */
function mouseoverPriceItemCB(
  mouseoverTarget, chartContainerSelector, chartContainerID
) {
  var $chartContainer = $(chartContainerSelector);
  var position;

  if ($chartContainer.length !== 1) {
    console.error('Chart container result not 1', $chartContainer);
    return;
  }

  position = $(mouseoverTarget).offset();

  $chartContainer.css({
    position: 'absolute',
    display: 'inline-block',
    top: position.top,
    left: position.left + 40,

    height: '180px',
    width: '420px',

    'z-index': 10,
    'background-color': '#eee',
    border: '1px solid #ccc'
  });

  $.getJSON(mouseoverTarget.getAttribute('href')).done(function (data) {
    var chart = new Chartkick.LineChart(
      chartContainerID, data
    );

    $chartContainer.append(chart);
  }).fail(function (err) {
    console.error('FAILED!', err);
  });
}

function mouseoutPriceItemCB(chartContainerSelector) {
  $(chartContainerSelector).css({
    display: 'none'
  });
}

$(document).ready(
  function () {
    var pricesTableIDBase = 'prices-table';
    var pricesTableID = `#${pricesTableIDBase}`;

    $(pricesTableID).bind('DOMSubtreeModified', function () {
      var pricesTableSelector = `${pricesTableID} td a.popup_chart_data`;
      var chartContainerID = 'popup_chart_container';
      var chartContainerSelector = `div#${chartContainerID}`;

      $(`${pricesTableSelector}:not(.bound)`).addClass('bound').mouseover(
        function () {
          mouseoverPriceItemCB(
            this, chartContainerSelector, chartContainerID
          );
        }
      );

      $(pricesTableSelector).mouseout(function () {
        mouseoutPriceItemCB(chartContainerSelector);
      });
    });
  }
);

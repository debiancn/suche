document.observe('dom:loaded', function() {
  new Ajax.Autocompleter('search', 'result', '/package', {
      method: 'get',
      minChars: 2,
      updateElement: function(item) {}
      });
});

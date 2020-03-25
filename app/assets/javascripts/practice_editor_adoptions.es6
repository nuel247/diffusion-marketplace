(($) => {
    const $document = $(document);

    function loadPracticeEditorFunctions() {
        // relies on `_facilitySelect.js` utility file to be loaded prior to this file
        getFacilitiesByState(facilityData);
    }

    $document.on('turbolinks:load', loadPracticeEditorFunctions);
})(window.jQuery);
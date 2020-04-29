function detectIE() {
    return /MSIE|Trident/.test(window.navigator.userAgent);
}

(($) => {
    const $document = $(document);

    function browseHappy() {
        if (detectIE() && !$('.browsehappy').length && window.location.href.split('/').pop() == '') {
            $('header').after(`
                <div class="grid-container">
                    <div class="usa-alert usa-alert--warning">
                      <div class="usa-alert__body">
                        <p class="browsehappy">
                            Diffusion Marketplace is not optimized for this browser. 
                            Some features may not be available. For the best experience, please use the latest versions of 
                            Microsoft Edge or Google Chrome.
                        </p>
                      </div>
                    </div>
                </div>
            `);
        }

    }

    $document.on('turbolinks:load', browseHappy);
})(window.jQuery);

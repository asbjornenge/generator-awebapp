require.config({
    baseUrl : '/scripts',
    paths: {
        jquery : '../bower_components/jquery/jquery'
    }
});

require(['jquery'], function($) {
    $(document).ready(function() {
        console.log("eplekake2");
    });
});


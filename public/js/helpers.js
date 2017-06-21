/**
 * Created by mva on 05/06/2017.
 */

function showResult  (value) {
    $(".result .alert-success").removeClass("hidden");
    $(".result .alert-success").text(value);
};
var showError = function (value) {
    $(".result .alert-danger").removeClass("hidden");
    $(".result .alert-danger").text(value);
}
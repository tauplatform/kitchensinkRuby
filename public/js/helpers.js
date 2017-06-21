/**
 * Created by mva on 05/06/2017.
 */

function showResult  (value) {
    $(".result .success").removeClass("hidden");
    $(".result success").text(value);
};
var showError = function (value) {
    $(".result .success").removeClass("hidden");
    $(".result .error").text(value);
}
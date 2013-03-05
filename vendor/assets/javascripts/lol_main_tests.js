//= require ./Jasmine/jasmine
//= require ./Jasmine/jasmine-html
//= require ./LolFramework/Tests/Library
//= require ./LolFramework/Tests/Lol
//= require ./LolFramework/Tests/Lang
//= require ./LolFramework/Tests/I18n
//= require ./LolFramework/Tests/Debug
//= require ./LolFramework/Tests/Utils
//= require ./LolFramework/Tests/Core
//= require ./LolFramework/Tests/Alert
//= arequire ./LolFramework/Tests/Button
//= arequire ./LolFramework/Tests/Loader
//= arequire ./LolFramework/Tests/Ajax
//= arequire ./LolFramework/Tests/Modal
//= arequire ./LolFramework/Tests/Model
//= arequire ./LolFramework/Tests/Model/Rest
//= arequire ./LolFramework/Tests/Datatable
//
// //= require_self

var jasmineEnv = jasmine.getEnv();
jasmineEnv.updateInterval = 1000;

var htmlReporter = new jasmine.HtmlReporter();

jasmineEnv.addReporter(htmlReporter);

jasmineEnv.specFilter = function(spec) {
    return htmlReporter.specFilter(spec);
};

var currentWindowOnload = window.onload;

window.onload = function() {
    if (currentWindowOnload) {
        currentWindowOnload();
    }
    execJasmine();
};

function execJasmine() {
    jasmineEnv.execute();
}
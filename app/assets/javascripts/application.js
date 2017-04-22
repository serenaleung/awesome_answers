// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require welcome
//= require chosen-jquery 
//= require_tree .

// The last 3 lines in the comments above are instructions for the
// manifest file. When you see `//=` in the manifest file, this is actually a
// piece of instruction. In the lines above the instructions state that
// we will include `jquery` first then we will include `jquery_ujs` second,
// both of those come from Gems included by Rails by default.
// `require_tree . ` will require all files / folder / subfolders.. recursively
// within the same folder as this file. The files will be included in an
// alphabetical order by default.
// Not that locally when we're in development mode, the files wil be included
// individually (separately) but when we got to the production they will all get
// compiled into a single file called application-DIGEST.js
// If you add your own `require` statements then you can choose to include files
// in non-alphabetical order

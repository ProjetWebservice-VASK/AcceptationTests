require 'cucumber/formatter/unicode' # Pour le support de l'UTF-8 pour Cucumber
require 'watir-webdriver'

browser = Watir::Browser.new :firefox

Soit /^un usager sur l'application web$/ do
  browser.goto 'http://google.com'
  browser.text_field(:name => 'q').set("WebDriver rocks!")
  browser.button(:name => 'btnG').click
  puts browser.url
  browser.close
end

Lorsque(/^l'usager pose une question au serveur$/) do
  pending
end

Alors(/^le serveur indique qu'il a enregistré la question$/) do
  pending
end

Et(/^il permet à l'usager de localiser la réponse lorsqu'elle sera disponible$/) do
  pending
end
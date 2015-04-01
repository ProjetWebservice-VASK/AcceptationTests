require 'cucumber/formatter/unicode' # Pour le support de l'UTF-8 pour Cucumber
require 'watir-webdriver'

browser = Watir::Browser.new :firefox

Soit /^un usager sur l'application web$/ do
  browser.goto 'file:///Users/Vincent/Workspace/Javascript/Question-Client/index.html'
  puts browser.url
end

Lorsque(/^l'usager pose une question au serveur$/) do
  browser.a(:href => '#myModal').click
  browser.textarea(:id => 'answerText').set('Que suis-je en train de faire ?')
  browser.button(:id => 'submitNewQuestion').click
end

Alors(/^le serveur indique qu'il a enregistré la question$/) do
  Watir::Wait.until(5) { browser.div(:class => 'humane').text.include? 'Question enregistrée' }
end

Et(/^il permet à l'usager de localiser la réponse lorsqu'elle sera disponible$/) do
  browser.div(:id => 'questions')
    .div(:id => 'accordion')
    .div(:index => 0)
    .h4(:class => 'panel-title').text.include? 'Que suis-je en train de faire ?'

  browser.close
end
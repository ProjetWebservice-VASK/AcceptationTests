require 'cucumber/formatter/unicode' # Pour le support de l'UTF-8 pour Cucumber
require 'watir-webdriver'

browser = Watir::Browser.new :firefox
number_of_questions = 0

Soit /^un usager sur l'application web$/ do
  browser.goto 'file:///Users/Vincent/Workspace/Javascript/Question-Client/index.html'
  puts browser.url

  sleep 5

  if browser.div(:id => 'questions').exists?
    number_of_questions = browser.div(:id => 'questions')
      .divs(:class => 'panel-group').length
  end
end

Lorsque(/^l'usager pose une question au serveur$/) do
  browser.a(:href => '#myModal').click
  browser.textarea(:id => 'answerText').set('Que suis-je en train de faire ?')
  browser.button(:id => 'submitNewQuestion').click
end

Alors(/^le serveur indique qu'il a enregistré la question$/) do
  Watir::Wait.until(10) { browser.div(:class => 'humane').text.include? 'Probléme' }
end

Et(/^il permet à l'usager de localiser la réponse lorsqu'elle sera disponible$/) do
  Watir::Wait.until(10) { browser.div(:id => 'questions').exists? && browser.div(:id => 'questions').divs(:class => 'panel-group').length == number_of_questions + 1 }

  browser.div(:id => 'questions')
    .div(:id => 'accordion')
    .div(:index => 0)
    .h4(:class => 'panel-title').text.include? 'Que suis-je en train de faire ?'

  browser.close
end
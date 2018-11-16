require 'watir'
require 'watir-scroll'
require 'open-uri'
require 'nokogiri'
require 'awesome_print'

login[:username] = ENV['TWITTER_EMAIL']
login[:password] = ENV['TWITTER_PASSWD']

#login = {:username => "EMAIL", :password => "MOT DE PASSE}

timer_lazyloading = 1.2

browser = Watir::Browser.new :firefox :headless

#CONNEXION
browser.goto "https://twitter.com/login"

puts "J'attends que la page de connexion s'affiche"
browser.button(:class => ["submit", "EdgeButton", "EdgeButton--primary", "EdgeButtom--medium"]).wait_until_present
puts "Le bouton est présent, je peux me connecter !".green
browser.input(:class => ["js-username-field", "email-input", "js-initial-focus"]).to_subtype.set(login[:username])
sleep(0.5)
browser.input(:class => "js-password-field").to_subtype.set(login[:password])
sleep(0.5)
browser.button(:class => ["submit", "EdgeButton", "EdgeButton--primary", "EdgeButtom--medium"]).click
puts "J'attends d'être connecté"
browser.input(:class => "search-input").wait_until_present
puts "Je suis bien connecté !".green

#EXTRACTION LISTE DEPUTES
previoususers = []
currentusers = []

browser.goto "https://twitter.com/search?f=users&vertical=default&q=d%C3%A9put%C3%A9&src=typd"

while 1
  previoususers = currentusers
  browser.scroll.to :bottom
  sleep(timer_lazyloading)
  doc = Nokogiri::HTML(browser.html)
  currentusers = doc.css('a.ProfileNameTruncated-link').map { |link| link['href'] }
  if currentusers.last == previoususers.last
    @currentusers = currentusers
    break
  end
end

print @currentusers

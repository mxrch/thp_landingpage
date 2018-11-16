require "nokogiri"
require "open-uri"
require 'watir'
require 'awesome_print'

class ScrapCorp

  def initialize
    @emails = []
    @currentcorps = []
  end

  def start
    browser = Watir::Browser.new :firefox

    150.times do |count| #Default 4060

      puts "--------------- PAGE #{count} -------------".blue
      doc = Nokogiri::HTML.parse(open("http://www.alsaeco.com/annuaire/annuaire-des-entreprises-alsace/field_aa_circonscription/strasbourg-4013?page=#{count}"))
      doc.search("span.field-content a[rel=cci_link]").each do |corp|
        unless @currentcorps.include? corp.text
          @currentcorps << corp.text
        end
      end

      for corp in @currentcorps
        browser.goto "https://www.bing.com/search?q=%22#{corp}%22+strasbourg"
        browser.li(:class => "b_algo").wait_until_present
        puts corp.yellow
        doc = Nokogiri::HTML.parse(browser.html)

        link = doc.at_css("li.b_algo a")['href']
        begin
          currentpage = Nokogiri::HTML.parse(open(link))
          currentemails = currentpage.inner_html.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
          if currentemails[0]
            puts currentemails.join(', ').green
          else
            puts "Aucun email".red
          end
          for email in currentemails
            @emails << email
          end
          puts "\n\n"
        rescue OpenURI::HTTPError, OpenSSL::SSL::SSLError, Net::ReadTimeout, ArgumentError
          puts "Erreur".red
          puts "\n\n"
        end
      end
      @currentcorps = []
    end

    return @emails.flatten!.uniq!
  end

  def perform
    return start
  end

end

ScrapCorp.new.perform

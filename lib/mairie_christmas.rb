require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'



# -------------------------------------------------------------
# fonction qui récupère l'adresse email d'une mairie
def get_townhall_email(townhall_url)

	page = Nokogiri::HTML(open(townhall_url)) 

	return email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()').text

end


# -------------------------------------------------------------
# fonction qui récupère les url des différentes mairies du Val d'Oise
def get_townhall_urls

	# on dit au programme d'ouvrir la page contenant l'annuaire des mairies du Val d'Oise
	page = Nokogiri::HTML(open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
	
	# on dit au programme d'aller chercher le xpath correspondant au lien de chaque maire
	#townhall_url = page.xpath('//*[@id="voyance-par-telephone"]/table/tbody/tr[2]/td/table/tbody/tr/td[1]/p/a[1]').text
	townhall_url = page.xpath('//a[@class = "lientxt"]')
	
	# On définit un tableau qui va contenir les adresses mail complètes de toutes les mairies du Val d'Oise
	townhall_url_array = []

	townhall_url.each do |balise_a_html|
		townhall_url_array << "https://www.annuaire-des-mairies.com/#{balise_a_html['href']}"
	end

	# On retourne le tableau contenant toutes les adresses email.
	return townhall_url_array

end


# -------------------------------------------------------------
# fonction qui récupère les noms des mairies du Val d'Oise
def get_town_names

	# on dit au programme d'ouvrir la page contenant l'annuaire des mairies du Val d'Oise
	page = Nokogiri::HTML(open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
	
	# on dit au programme d'aller chercher le xpath correspondant au lien de chaque maire
	#townhall_url = page.xpath('//*[@id="voyance-par-telephone"]/table/tbody/tr[2]/td/table/tbody/tr/td[1]/p/a[1]').text
	townhall_names = page.xpath('//a[@class = "lientxt"]/text()')
	
	# On définit un tableau qui va contenir les adresses mail complètes de toutes les mairies du Val d'Oise
	townhall_names_array = []

	townhall_names.each do |townhall_name|
		townhall_names_array << townhall_name.text
	end

	# On retourne le tableau contenant toutes les adresses email.
	return townhall_names_array

end



# -------------------------------------------------------------
# 
def perform

	townhall_email_array = []

	get_townhall_urls.each do |url|
		townhall_email_array << get_townhall_email(url)
	end


# On créé le tableau final qui contiendra les hashs
	emails_array = []
	# On créé les hash qui contiendront les noms des mairies en clé et les adresses emails en valeur
	email_hash = {} # Ou : email_hash = Hash.new

	i = 0

	
	while i < get_town_names.size do 	
		email_hash = {get_town_names[i] => townhall_email_array[i]}
		emails_array << email_hash
		i += 1
	end
	
	return emails_array

end

puts perform

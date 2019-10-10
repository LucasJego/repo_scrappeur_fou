require 'nokogiri'
require 'open-uri'


def page
	return Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
end
#//a[@class='currency-name-container link-secondary']



def crypto()
	# td sont les colonnes du tableau du site et tr sont les lignes
	# si je veux la 3 ème colonne je fait //td[3]
	crypto = page.xpath('//td[3]')
	return crypto
end

def valeur()
	valeur = page.xpath("//a[@class='price']") # Dans le inspec nous pouvons qu'il existe une class 'price'
	#le lien /a signifie que les valeurs sont des liens hypertext
	return valeur
end

def method_name()
	i = 0
	crypto = crypto() # on récupère données renvoyée par les def
	valeur = valeur()
	tabl = [] # on créé un tableau vide pour stocker les hash
	while i < valeur.length
		nouveauHash = Hash.new()# on créé un nouveau hash à chaque tour de boucle
		nouveauHash[crypto[i].text] = valeur[i].text.delete("$") # on rentre les valeurs dans le hash
		tabl << nouveauHash # on met chaque hash dans le tableau
		i+=1
	end
	return tabl
end

puts method_name()
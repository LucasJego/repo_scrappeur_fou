require 'nokogiri'
require 'open-uri'

# -------------------------------------------------------------
def page
  return page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
end


# -------------------------------------------------------------
# Fonction qui récupère la liste des députés
def deputes(page)
  list_deputes = page.xpath("//ul[@class='col3']//li//a")
    return list_deputes
end


# -------------------------------------------------------------
# Fonction qui récupère les url
def get_deputes_urls(page)

  url = page.xpath("//ul[@class='col3']//li//a")
  tableau = []
  url.each do |townhall_url|
      tableau << "http://www2.assemblee-nationale.fr" + townhall_url['href']
  end

  return tableau

end


# -------------------------------------------------------------
# Fonction qui 
def get_deputes_email()
  i = 0
  table = get_deputes_urls(page)
  deputes_email = []
  while i < table.length # mettre un valeur 10 par exemple pour faire le test
    page2 = Nokogiri::HTML(open(table[i]))# ouverture d'une nouvelle page pour chaque élément du tableau
    deputes_email << page2.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a/text()")
    i += 1
  end
  return deputes_email
end


# -------------------------------------------------------------
def make_hashe()
  i = 0
  email = get_deputes_email()
  nom_depute = deputes(page)
  tableau_depute_mail = []

  while i < nom_depute.length # mettre un valeur 10 par exemple pour faire le test
    nouveau_hash = Hash.new()
    nouveau_hash[nom_depute[i].text] = email[i].text
    tableau_depute_mail << nouveau_hash
    i += 1
  end
  return tableau_depute_mail
end


puts make_hashe()
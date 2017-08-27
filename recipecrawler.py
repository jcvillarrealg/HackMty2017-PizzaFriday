"""
"""
#Required imports
from lxml import html
import requests
import urllib
from nltk.corpus import stopwords
import json


# Request the name of the relevant files to the user
print("Name with the urls for the recipes?")
urls_file = raw_input()

vegetarian = False
urls = []
count = 0

with open(urls_file) as file_obj:
	lines = file_obj.readlines()

urls = [line.strip() for line in lines]


# File for the information about the downloaded images
dbsource = open('dbsource', "w")

title = ''
ingredients = '' #List
ingredients_str = '' #String with stopwords removal
nutritional_facts = '' #List
time = ''
image_url = ''

# Iterate over the list of retrieved URLs
for url in urls:

	# Get the web page related to the current URL
	page = requests.get(url)

	# Parse the HTML structure that constitutes the page
	tree = html.fromstring(page.content)

	vegetarian = "icon-vegetarian" in page.content

	# Extract the author of the current image
	try:
		title = title = tree.xpath("//body/div/section[@id='recipe-single']/div[@class='container recipe-container']/div[@class='row recipe-header']/div[@class='col-lg-9 col-sd-12 col-md-12 col-sm-12']/div[@class='row']/div[@class='col-lg-7 col-md-7 col-sm-6 col-sm-ls-5 single-recipe-details']/h1/text()")[0]
	except:
		title = "Not Provided"

	# Extract the title of the current image
	try:
		ingredients = tree.xpath("//body/div/section[@id='recipe-single']/div[@class='container recipe-container']/div[@class='row recipe-header']/div[@class='col-lg-9 col-sd-12 col-md-12 col-sm-12']/div[@class='row'][2]/div[@class='recipe-left-col col-sm-5 col-md-4 col-sd-4 col-lg-4']/div[@class='recipe-ingredients']/div[@class='row']/div[@class='col-md-12 ingredient-wrapper']/ul/li/text()")
		ingredients_string = ''
		list_ingredients = []
		for ing in ingredients:
		    ing = ing.replace(',', ' ')
		    ing = ing.split()
		    ing = ' '.join(ing)
		    list_ingredients.append(ing)
		    
		#ingredients_string = ']'
		ingredients_json_list = '[' + ', '.join(list_ingredients) + ']'
		#ingredients_string = ', '.join(list_ingredients)
		#ingredients_string = [word for word in ingredients_string.split() if word not in stopwords.words('english') and word not in ['g', 'ml'] and word.isdigit() is False]

		output_string = ''
		for i in range(len(list_ingredients)):
		    list_ingredients[i] = [word for word in list_ingredients[i].split() if word not in stopwords.words('english') and word not in ['g', 'ml'] and word.isdigit() is False]
		    list_ingredients[i] = ' '.join(list_ingredients[i])
		ingredients_string = ', '.join(list_ingredients)
	except:
		ingredients = "Not Provided"

	# Extract the license of the current image
	try:
		nutritional_facts = "[]"
	except:
		nutritional_facts = "Not Provided"

	try:
		time = tree.xpath("//body/div/section[@id='recipe-single']/div[@class='container recipe-container']/div[@class='row recipe-header']/div[@class='col-lg-9 col-sd-12 col-md-12 col-sm-12']/div[@class='row']/div[@class='col-lg-7 col-md-7 col-sm-6 col-sm-ls-5 single-recipe-details']/div[@class='row']/div[@class='col-md-12']/div[@class='row recipe-details']/div[@class='col-lg-6 col-sd-12 col-md-12 recipe-details-col remove-left-col-padding-md']/div[@class='recipe-detail time']/text()")
		for i in range(len(time)):
		    time[i] = time[i].strip()
		time = ' '.join(time).strip()
	except:
		time = "Not Provided"

	try:
		image_url = tree.xpath("//head/meta[@property='og:image']/@content")[0]
	except:
		image_url = "Not Provided"

	json_object = [{"title": title, "ingredients": ingredients_json_list, "ingredients_str": ingredients_string, "nutritional_facts": nutritional_facts, "time": time, "url": url, "image_url":image_url, "vegetarian": vegetarian}]

	#print json.dumps(json_object)
	count += 1
	print("Processed URL " + str(count))
	dbsource.write(json.dumps(json_object) + '\n')

dbsource.close()



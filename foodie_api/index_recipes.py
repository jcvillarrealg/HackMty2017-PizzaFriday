import sys
import requests
import json

doc_num = 1
with open('dbsource.json', "r", encoding="utf-8") as f:
    for line in f:
        if doc_num > 0 :
            recipe = json.loads(line)
            requests.post(url=' http://localhost:9200/recipes_index' + '/recipe/', data=json.dumps(recipe))
            print('Added document:\t' + str(doc_num))
        doc_num += 1

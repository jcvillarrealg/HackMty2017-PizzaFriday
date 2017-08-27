var request = require('request');
var elasticsearch = require('elasticsearch');
var cognitiveServices = require('cognitive-services')
const computerVision = cognitiveServices.computerVision({
    API_KEY: '5d141497b52f48e0ad5c5b6f0e00f3b2'
})
const Storage = require('@google-cloud/storage');
const cloudId = 'foodie-bc5cc';
const storage = Storage({
  projectId: cloudId
});
var bucket = storage.bucket('foodie-bc5cc.appspot.com');

var esClient = new elasticsearch.Client({
  host: '127.0.0.1:9200',
  requestTimeout: 120000,
  keepAlive: false,
  log: 'error'
});

num_of_recipes = 10
attributes_for_response = ['title','url','image_url', 'time', 'method', 'nutritional_facts', 'ingredients']

exports.find = function(req, res){
  var ingredients_str = req.body.ingredients
  console.log(ingredients_str)
  base_search(ingredients_str, res, req)
};

exports.pic = function(req, res){
  var name = req.file.name
  uri = ''
  bucket.upload(name, function(err, file) {
    console.log('se pudo');
  });
  //var raw = new Buffer(req.file.buffer, 'binary').toString('binary')
  console.log(raw)

  const parameters = {
    visualFeatures: "Tags"
  };

  const body = {
    data : raw
  };
  /*
  computerVision.analyzeImage({
        parameters,
        raw
    })
    .then((response) => {
        console.log('Got response', response);
        res.format({
          json: function(){
            res.json(response);
          }
        });
    })
    .catch((err) => {
        console.error('Encountered error making request:', err);
        res.format({
          json: function(){
            res.json(err);
          }
        });
    });
    */
    res.format({
      json: function(){
        res.json('Ok');
      }
    });
};

function base_search(search_value,  res, req){
  esClient.search({
    index: 'recipes_index',
    type: 'recipe',
    size: num_of_recipes,
    body: {
      "query": {
        "bool":{
          "must":{
            "match": {
               "ingredients": search_value
            }
          }
        }
      }
    }
  }, function (error, response) {
    if(error){
      console.log("------------------------------------------------");
      console.log(error);
      console.log("------------------------------------------------");
    }
    return_recepies(response['hits']['hits'], attributes_for_response, res, req);
  });
}

function return_recepies(recepies_array, needed_attributes, res, req){
  formated_recipes = []
  recepies_array.forEach(function(rec){
    aux_rec = {}
    needed_attributes.forEach(function(at){
      if(at == 'method'){
        aux_rec[at] = rec['_source'][at].join("|")
      }
      else{
        aux_rec[at] = rec['_source'][at]
      }
    });
    formated_recipes.push(aux_rec)
  });
  res.format({
    json: function(){
      res.json(formated_recipes);
    }
  });
}

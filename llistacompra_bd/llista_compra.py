# La llista de la compra pels alumnes de DAW

from flask import Flask, request, jsonify

app = Flask(__name__)


articles = []
last_id = 0

@app.route('/articles/<int:article_id>',
           methods=['GET', 'PUT', 'DELETE'])
def article(article_id=0):
  global last_id
  global articles
  if request.method == 'GET':
    trobat = [art for art in articles if art["id"] == article_id]
    if len(trobat) > 0:
      return jsonify(trobat[0])
    return jsonify({}), 404
  elif request.method == 'DELETE':
    trobat = [art for art in articles if art["id"] == article_id]
    if len(trobat) > 0:
      articles.remove(trobat[0])
    return jsonify({}), 204
  elif request.method == 'PUT':
    for index, value in enumerate(articles):
      if value["id"] == article_id:
        articles[index] = request.json
        return jsonify(articles[index]), 200


@app.route('/articles', methods=['GET', 'POST'])
def get_articles():
  global articles
  global last_id
  if request.method == 'GET':
    return jsonify(articles)
  elif request.method == 'POST':
    last_id +=1
    article = {
        'id': last_id,
        'nom': request.json['nom'],
        'quantitat': request.json['quantitat']
    }
    articles.append(article)
    return jsonify(article), 201
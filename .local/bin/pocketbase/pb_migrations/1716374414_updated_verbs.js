/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("fcvsyh26b9rqp97")

  collection.options = {
    "query": "SELECT id, word FROM vocabularies WHERE type IN ('verb');"
  }

  // remove
  collection.schema.removeField("etyfulow")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "myme14yt",
    "name": "word",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("fcvsyh26b9rqp97")

  collection.options = {
    "query": "SELECT id, word FROM vocabularies;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "etyfulow",
    "name": "word",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // remove
  collection.schema.removeField("myme14yt")

  return dao.saveCollection(collection)
})

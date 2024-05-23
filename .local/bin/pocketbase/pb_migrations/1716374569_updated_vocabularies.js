/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // remove
  collection.schema.removeField("ejeztsc7")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ejeztsc7",
    "name": "type",
    "type": "select",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSelect": 2,
      "values": [
        "verb",
        "adjective",
        "noun",
        "preposition"
      ]
    }
  }))

  return dao.saveCollection(collection)
})

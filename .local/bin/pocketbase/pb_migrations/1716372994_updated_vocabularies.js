/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // remove
  collection.schema.removeField("tbqrp8lz")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tbqrp8lz",
    "name": "meanings",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
})

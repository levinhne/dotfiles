/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "umrmjty9",
    "name": "types",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "4v82r2nr8h1umy1",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("33yvd9jy4733vib")

  // remove
  collection.schema.removeField("umrmjty9")

  return dao.saveCollection(collection)
})

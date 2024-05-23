/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "4v82r2nr8h1umy1",
    "created": "2024-05-22 10:42:08.874Z",
    "updated": "2024-05-22 10:42:08.874Z",
    "name": "vocabularies_types",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "dulindt9",
        "name": "name",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("4v82r2nr8h1umy1");

  return dao.deleteCollection(collection);
})

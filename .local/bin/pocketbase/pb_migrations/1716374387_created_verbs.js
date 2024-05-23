/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "fcvsyh26b9rqp97",
    "created": "2024-05-22 10:39:47.749Z",
    "updated": "2024-05-22 10:39:47.749Z",
    "name": "verbs",
    "type": "view",
    "system": false,
    "schema": [
      {
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
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT id, word FROM vocabularies;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("fcvsyh26b9rqp97");

  return dao.deleteCollection(collection);
})

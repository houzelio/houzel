import Entity from 'javascripts/core/entities/entity'
import sinon from 'sinon'

describe("Entity", () ->
  MyEntity = Entity.extend({
    urlRoot: "/foo-model"
    url: "/foo-collection"
  })

  beforeEach ->
    @server = sinon.fakeServer.create()
    @myEntity = new MyEntity

  afterEach ->
    @server.restore()

  describe("with model and/or collection class", () ->
    beforeEach ->
      @MyModel = Backbone.Model.extend(urlRoot: "/foo-model")
      @MyCollection = Backbone.Collection.extend(url: "/foo-collection")

      MyOtherEntity = MyEntity.extend({
        modelClass: @MyModel
        collectionClass: @MyCollection
      })

      @myEntity = new MyOtherEntity

    it("shoud associate the model class defined with the entity", () ->
      expect(@myEntity._getModel()).toBeInstanceOf(@MyModel)
    )

    it("shoud associate the collection class defined with the entity", () ->
      expect(@myEntity._getCollection()).toBeInstanceOf(@MyCollection)
    )
  )

  describe("without a model and/or collection class", () ->
    it("should set up a model class with the urlRoot", () ->
      myModel = @myEntity._getModel()
      expect(myModel).toBeInstanceOf(Backbone.Model)
      expect(myModel.urlRoot).toBe("/foo-model")
    )

    it("should set up a collection class with the url", () ->
      myCollection = @myEntity._getCollection()
      expect(myCollection).toBeInstanceOf(Backbone.Collection)
      expect(myCollection.url).toBe("/foo-collection")
    )

    it("should use the urlRoot as default when setting up a collection class whithout the url option", () ->
      MyOtherEntity = Entity.extend({
        urlRoot: "/foo"
      })

      myEntity = new MyOtherEntity
      myCollection = myEntity._getCollection()
      expect(myCollection.url).toBe("/foo")
    )

    it("should set up a model class with validation when it's set", () ->
      MyOtherEntity = Entity.extend({
        urlRoot: "/foo"
        validation:
          patient_id:
            required: true
            msg: "Required field"
      })

      myEntity = new MyOtherEntity
      myModel = myEntity._getModel()
      expect(_.allKeys(myModel)).toContain('validation')
    )
  )

  describe("::create", () ->
    beforeEach ->
      MyOtherEntity = Entity.extend(urlRoot: "/foo/model")
      @myEntity = new MyOtherEntity

    it("creates a new model", () ->
      myModel = @myEntity.create(name: 'Luccas Marks')

      expect(myModel.isNew()).toBe(true)
      expect(myModel.get('name')).toBe('Luccas Marks')
    )

    it("creates a new model fetching data from server", () ->
      url = new RegExp("/foo\\/model\\/new\\w*")
      @server.respondWith("GET", url,
                       [
                         200,
                         { "Content-Type": "application/json" },
                         JSON.stringify({name: "Joseane Fogaça"})
                       ])

      myModel = @myEntity.create(null, {urlRoot: "/foo/model/new", fetch: true})
      @server.respond()

      expect(myModel._fetch.status).toBe(200)
      expect(myModel.get('name')).toBe("Joseane Fogaça")
    )
  )

  describe("::get", () ->
    it("gets a model", () ->
      url = new RegExp("/foo-model\\/2\\w*")
      @server.respondWith("GET", url,
                       [
                         200,
                         { "Content-Type": "application/json" },
                         JSON.stringify({id:2, name: "Ella Fay"})
                       ])

      myModel = @myEntity.get(2)
      @server.respond()

      expect(myModel._fetch.status).toBe(200)
      expect(myModel.get('name')).toBe("Ella Fay")
    )
  )

  describe("::getList", () ->
    it("gets a collection", () ->
      url = new RegExp("/foo-collection\\?page\\=1&per_page\\=10\\w*")
      @server.respondWith("GET", url,
                       [
                         200,
                         { "Content-Type": "application/json" },
                         JSON.stringify({
                           items: [{id: 1, name: "Joseane Fogaça"}, {id: 2, name: "Ella Fay"}]
                          })
                       ])

      myCollection = @myEntity.getList()
      @server.respond()

      expect(myCollection.length).toBe(2)
      expect(myCollection.get(2).get('name')).toBe("Ella Fay")
    )
  )
)

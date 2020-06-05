import GridCmp from 'javascripts/core/components/grid'
import PageableCollection from "backbone.paginator"

describe("Grid Component", () ->
  MyModel = Backbone.Model.extend({})

  MyCollection = PageableCollection.extend({
    model: MyModel
    url: '/test'

    state:
      pageSize: 2
      totalRecords: 3
  })

  beforeEach ->
    setFixtures(__html__['my-grid.html'])

    @myModels = [
      new MyModel({id: 1, name: "Joseane Fogaça", phone_number: "96789-6991"}),
      new MyModel({id: 2, name: "Ella Fay", phone_number: "218-785-4836"}),
      new MyModel({id: 3, name: "晋珊完颜", phone_number: "13840-870672"})
    ]

  it("attachs the collection", () ->
    collection = new MyCollection
    myGrid = new GridCmp({columns: [], collection: collection})
    expect(myGrid.getCollection()).toEqual(collection)
  )

  it("should set up a collection if the one ain't passed", () ->
    myGrid = new GridCmp(columns: [])
    expect(myGrid.getCollection()).toEqual(jasmine.any(Backbone.Collection))
  )

  describe("::showView", () ->
    beforeEach ->
      @myGrid = new GridCmp({el:'#grid', columns: []} )

      @columns = [{ name: 'name', cell: 'string'}]
      @myOtherGrid = new GridCmp({ el:'#grid', columns: @columns, collection: new MyCollection(@myModels)})

    it("shows grid within an HTML element", () ->
      @myGrid.showView()
      expect($('#grid')[0]).toContainElement('table.table')
    )

    it("should replace the grid on Dom with the new if the el set is the same", () ->
      @myGrid.showView()
      expect($('#grid')[0]).not.toContainText('Joseane Fogaça')
      @myOtherGrid.showView()
      expect($('#grid')[0]).toContainText('Joseane Fogaça')
    )

    it("shows paginator automatically when 'totalRecords' is more than 'windowsSize'", () ->
      @myOtherGrid.initialize(windowSize: 2)
      spyOn(@myOtherGrid, 'showPaginator')
      @myOtherGrid.showView()
      expect(@myOtherGrid.showPaginator).toHaveBeenCalled()
    )

    it("should do not show paginator when 'totalRecords' is less than 'windowsSize'", () ->
      spyOn(@myOtherGrid, 'showPaginator')
      @myOtherGrid.showView()
      expect(@myOtherGrid.showPaginator).not.toHaveBeenCalled()
    )

    it("should remove the thead when 'removeThead' is set to true", () ->
      @myGrid.initialize(removeThead: true)
      @myGrid.showView()
      expect($('#grid')[0]).not.toContainHtml('<thead></thead>')
    )
  )

  describe("normalizing", () ->
    beforeEach ->
      @spy = jasmine.createSpyObj('spy', ['formatter', 'click'])
      @spy.formatter.and.callFake((rawData, model) ->
        rawData
      )

      columns = [
        name: 'phone_number'
        formatter: @spy.formatter
        thClassName: 'phone_number-render'
        cell: extend:
          template: _.template(
           """<a href="javascript:void(0);" data-check="true">
                <span>Phone Number: <%= phone_number %> </span>
              </a>"""
          )

          events:
            'click a[data-check="true"]' : () =>
              @spy.click()
      ]

      @myGrid = new GridCmp({ el:'#grid', columns: columns, collection: new MyCollection(@myModels)})

    it("supports a custom formatter function", () ->
      @myGrid.showView()
      expect(@spy.formatter).toHaveBeenCalled()
    )

    it("adds css classes to th element", () ->
      @myGrid.showView()
      expect($('#grid')[0]).toContainElement('th.phone_number-render')
    )

    describe("cell", () ->
      it("renders a custom template function", () ->
        @myGrid.showView()
        expect($('#grid').find('a')[0]).toHaveAttr('data-check', 'true')
      )

      it("catches dom events triggered from the template", () ->
        @myGrid.showView()
        $('#grid').find('a').first().click()
        expect(@spy.click).toHaveBeenCalled()
      )
    )
  )

  describe("manipulating elements", () ->
    beforeEach ->
      @spy = jasmine.createSpyObj('spy', ['add', 'remove', 'change'])

      columns = [{ name: 'id', cell: 'string'}, {name: 'name', cell: 'string'}]
      @myGrid = new GridCmp({ el:'#grid', columns: columns, collection: new MyCollection(@myModels)})
      @myGrid.showView()

      @myObject = new Marionette.MnObject()

    describe("by adding", () ->
      beforeEach ->
        @myObject.listenTo(@myGrid, 'grid:add', @spy.add)
        @myGrid.addElement(new MyModel({id: 4, name: "Luccas Marks"}))

      it("adds the element to Dom", () ->
        expect($('#grid')[0]).toContainText(4)
      )

      it("triggers event", () ->
        expect(@spy.add).toHaveBeenCalled()
      )
    )

    describe("by removing", () ->
      beforeEach ->
        @myObject.listenTo(@myGrid, 'grid:remove', @spy.remove)
        @myGrid.removeElement(@myModels[2])

      it("removes the element from Dom", () ->
        expect($('#grid')[0]).not.toContainText(3)
      )

      it("triggers event", () ->
        expect(@spy.remove).toHaveBeenCalled()
      )
    )

    describe("by changing", () ->
      beforeEach ->
        @myObject.listenTo(@myGrid, 'grid:change', @spy.change)
        @myModels[1].set('name', 'Ms. Ella Fay')

      it("changes the element on Dom", () ->
        expect($('#grid')[0]).toContainText('Ms. Ella Fay')
      )

      it("triggers event", () ->
        expect(@spy.change).toHaveBeenCalled()
      )
    )
  )

  describe("::showPaginator", () ->
    it("shows paginator independently of grid to have been showed", () ->
      $('<div id="otherPaginator">').prependTo('body')

      myGrid = new GridCmp({collection: new MyCollection(@myModels), windowSize: 2})
      myGrid.showPaginator($('#otherPaginator'))
      expect($('#otherPaginator')[0]).toContainElement('ul.pagination')
    )
  )
)

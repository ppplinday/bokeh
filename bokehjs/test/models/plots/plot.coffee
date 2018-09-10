{expect} = require "chai"
sinon = require 'sinon'

{Document} = require("document")

{clone} = require("core/util/object")
{CustomJS} = require("models/callbacks/customjs")
{DataRange1d} = require("models/ranges/data_range1d")
{Range1d} = require("models/ranges/range1d")
{Plot} = require("models/plots/plot")
{PlotView} = require("models/plots/plot")
{Toolbar} = require("models/tools/toolbar")

describe "test.models.plots.plot", ->

  describe "Plot", ->

    it "should not execute range callbacks on initialization", sinon.test () ->
      cb = new CustomJS()
      spy = this.spy(cb, 'execute')

      plot = new Plot({
        x_range: new Range1d({callback: cb})
        y_range: new Range1d({callback: cb})
      })
      expect(spy.called).to.be.false

  describe "PlotView", ->

    it "layout should set element style correctly", () ->
      plot = new Plot({x_range: new DataRange1d(), y_range: new DataRange1d(), width: 425, height: 658})
      view = new plot.default_view({model: plot, parent: null}).build()
      expected_style = "position: relative; display: block; left: 0px; top: 0px; width: 425px; height: 658px;"
      expect(view.el.style.cssText).to.be.equal(expected_style)

    it "should set min_border_x to value of min_border if min_border_x is not specified", () ->
      plot = new Plot({x_range: new DataRange1d(), y_range: new DataRange1d(), min_border: 33.33})
      view = new plot.default_view({model: plot, parent: null}).build()
      expect(view.layout.min_border.top).to.be.equal(33.33)
      expect(view.layout.min_border.bottom).to.be.equal(33.33)
      expect(view.layout.min_border.left).to.be.equal(33.33)
      expect(view.layout.min_border.right).to.be.equal(33.33)

    it "should set min_border_x to value of specified, and others to value of min_border", () ->
      plot = new Plot({x_range: new DataRange1d(), y_range: new DataRange1d(), min_border: 33.33, min_border_left: 66.66})
      view = new plot.default_view({model: plot, parent: null}).build()
      expect(view.layout.min_border.top).to.be.equal(33.33)
      expect(view.layout.min_border.bottom).to.be.equal(33.33)
      expect(view.layout.min_border.left).to.be.equal(66.66)
      expect(view.layout.min_border.right).to.be.equal(33.33)

    it "should set min_border_x to value of specified, and others to default min_border", () ->
      plot = new Plot({x_range: new DataRange1d(), y_range: new DataRange1d(), min_border_left: 4})
      view = new plot.default_view({model: plot, parent: null}).build()
      expect(view.layout.min_border.top).to.be.equal(5)
      expect(view.layout.min_border.bottom).to.be.equal(5)
      expect(view.layout.min_border.left).to.be.equal(4)
      expect(view.layout.min_border.right).to.be.equal(5)

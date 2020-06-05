import {formatCurr, rawValue, add} from 'javascripts/core/helpers/numeral'

describe("numeral", () ->
  describe("::formatCurr", () ->
    it("should return a formatted concurrency number", () ->
      expect(formatCurr(5220.12)).toBe("5,220.12")
    )
  )

  describe("::rawValue", () ->
    it("returns a number", () ->
      expect(rawValue("5,220.12")).toBe(5220.12)
    )
  )

  describe("::add", () ->
    it("plus two numbers", () ->
      expect(add(23.5, 21.5)).toBe(45)
    )

    it("plus a string number with a number", () ->
      expect(add("23.5", 21.5)).toBe(45)
    )
  )
)

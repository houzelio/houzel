import defaultLocale from "../../../../config/locales/javascript/en.yml"
import { t } from 'javascripts/core/helpers/i18n'

describe("i18n", () ->
  beforeAll ->
    @defaultPhrases = defaultLocale.json['en'].javascripts
    @phrases = {
      message: "Hi"
      interpolation: "%{message}"
      namespace:
        message: "Hi from namespace"
        innerNamespace:
          message: "Hi from innerNamespace"
    }

  afterEach ->
    t().load(phrases: @defaultPhrases)

  describe("::Intl::load", () ->
    it("overrides existing phrases", () ->
      pastPhrases = name: "Luna"
      lastPhrases = name: "Luccas"
      intl = t().load(phrases: pastPhrases)
      expect(t().polyglot.phrases.name).toBe("Luna")
      intl = t().load(phrases: lastPhrases)
      expect(t().polyglot.phrases.name).toBe("Luccas")
    )
  )

  describe("::t", () ->
    beforeEach ->
      t().load({phrases: @phrases, "en"})

    it("returns a Intl object as parameters are undefined", () ->
      intl = t()
      expect(intl).toEqual(jasmine.any(Object))
      expect(intl).not.toEqual(null)
    )

    it("returns the specified translation", () ->
      translation = t("message");
      expect(translation).toEqual("Hi");
    )

    it("can interpolate values", () ->
      translation = t("interpolation", message: "It works")
      expect(translation).toBe("It works")
    )

    it("will go through nested objects", () ->
      translation = t("namespace.innerNamespace.message")
      expect(translation).toBe("Hi from innerNamespace")
    )

    it("returns the missing key if translation is not found", () ->
      translation = t("missing.translation")
      expect(translation).toBe("missing.translation")
    )

    it("should return the same translation in javascript app and templates", () ->
      localTranslation = t("namespace.message")
      globalTranslation = window.t("namespace.message")
      expect(localTranslation).toBe(globalTranslation)
    )
  )
)

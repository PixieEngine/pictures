# define a template source that simply treats the template name as its content
ko.templateSources.stringTemplate = (template, templates) ->
    @templateName = "templates/#{template}"
    @templates = templates

    return this

ko.utils.extend ko.templateSources.stringTemplate.prototype,
  data: (key, value) ->
    @templates._data = @templates._data || {}
    @templates._data[@templateName] = @templates._data[@templateName] || {}

    if arguments.length is 1
      @templates._data[@templateName][key]
    else
      @templates._data[@templateName][key] = value

  text: (value) ->
    if arguments.length is 0
      @templates[@templateName]?() || @templates[@templateName]
    else
      @templates[@templateName] = value

# modify an existing templateEngine to work with string templates
createStringTemplateEngine = (templateEngine, templates) ->
  templateEngine.makeTemplateSource = (template) ->
    new ko.templateSources.stringTemplate(template, templates)

  templateEngine

ko.setTemplateEngine(createStringTemplateEngine(new ko.nativeTemplateEngine(), JST))

templates = {}

template = (name, ...params) ->
  templates[name].apply(null, params)

svgIcon = (icon, classes) ->
  """<svg class="svg-inline--hz #{classes}" data-icon=#{icon.name} xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 #{icon.width} #{icon.height}">
      <path fill="currentColor" d="#{icon.svgPathData}"</path>
     </svg>"""

gridActionButtons = (data) ->
  html = """<div class="pull-right">"""

  _.each(data.buttons, (button, index) ->
    ml = if index >= 1 then "class=\"ml-sm\" " else ""
    html += """<a #{ml}href="javascript:void(0);" data-click="button_#{index}">
                 <button type="button" class="btn btn-default btn-sm">"""

    if _.isObject(button.icon)
      html += svgIcon(_.result(button, 'icon'), 'hz-btn hz-fw-135')

    html += """#{_.result(button, 'title')}
                 </button>
               </a>"""
  )

  _.template(html.concat("</div>"))

templates['gridActionButtons'] = gridActionButtons

export default getTemplate = template

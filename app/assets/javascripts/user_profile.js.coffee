UserProfile = 
	init: ->
		$('body').on 'click', '.edit-svg', @showEditField
		$('body').on 'ajax:success', '#skill-form, #needed-skill-form', @addSkill
		$('body').on 'click', '.skill', @deleteSkill

	deleteSkill: ->
		return if $('.other').length > 0
		id = $(@).attr('id').slice(2)
		skill = $(@)
		if $(@).hasClass('have')
			url = "/skills/#{id}"
		else
			url = "/needed_skills/#{id}"
		$.ajax 
			url: url
			type: "delete"
			success: ->
				skill.remove()

	showEditField: ->
		$(@).parents('.field-header').next().toggle()

	addSkill: (event, data) ->
		$(@)[0].reset()
		skillList = $(@).parents('.field-row').next()
		skill = data.name

		if $(@).attr('id') == "skill-form"
			className = "have"
		else
			className = "needed"

		if skillList.find("#s-#{data.id}").length < 1
			skillList.append("<div class='skill #{className}' id='s-#{data.id}'>#{skill},&nbsp</div>")
			skillList.find("#s-#{data.id}").addClass('animated fadeIn')
		else
			form = $(@)
			form.find('input').val('Already Added')
			setTimeout ->
				form[0].reset()
			, 1000

ready = ->
	UserProfile.init()
$(document).ready ready
$(document).on 'page:load', ready
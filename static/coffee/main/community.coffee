
class S.CommunityNewTopic
  constructor: (el) ->
    @el = $ el

    form = @el.find("form")
    form.remote_submit (res) =>
      if res.errors
        form.set_form_errors res.errors
        return

      if res.redirect_to
        window.location = res.redirect_to

    S.redactor @el.find "textarea"


class S.CommunityPostForm
  constructor: (el, opts) ->
    @el = $ el
    S.redactor @el.find("textarea"), {
      minHeight: 100
    }

    form = @el.find("form")
    form.remote_submit (res) =>
      if res.errors
        form.set_form_errors res.errors
        return

      if res.redirect_to
        window.location = res.redirect_to


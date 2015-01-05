
db = require "lapis.db"
import assert_error from require "lapis.application"

not_found = { status: 404, render: "not_found" }

require_login = (fn) ->
  =>
    if @current_user
      fn @
    else
      redirect_to: @url_for"user_login"

require_admin = (fn) ->
  =>
    if @current_user and @current_user\is_admin!
      fn @
    else
      redirect_to: @url_for"index"

assert_timezone = (tz) ->
  res = unpack db.select "* from pg_timezone_names where name = ?", tz
  assert_error res, "invalid timezone: #{tz}"

login_and_return_url = (url=ngx.var.request_uri) =>
  import encode_query_string from require "lapis.util"
  @url_for("user_login") .. "?" .. encode_query_string {
    return_to: @build_url url
  }

{ :not_found, :require_login, :require_admin, :assert_timezone, :login_and_return_url }

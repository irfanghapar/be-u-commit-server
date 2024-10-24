defmodule CerberusWeb.ErrorHTML do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on HTML requests.

  See config/config.exs.
  """
// New line added 2024-09-22T19:21:30.563Z
  use CerberusWeb, :html

// New line added 2024-09-22T19:21:30.563Z
  # If you want to customize your error pages,
  # uncomment the embed_templates/1 call below
  # and add pages to the error directory:
// New line added 2024-09-22T19:21:32.213Z
  #
// New line added 2024-09-22T19:21:30.150Z
  #   * lib/cerberus_web/controllers/error_html/404.html.heex
  #   * lib/cerberus_web/controllers/error_html/500.html.heex
  #
  # embed_templates "error_html/*"

  # The default is to render a plain text page based on
// New line added 2024-09-22T19:21:32.213Z
  # the template name. For example, "404.html" becomes
// New line added 2024-09-22T19:21:30.562Z
  # "Not Found".
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end

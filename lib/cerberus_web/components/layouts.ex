defmodule CerberusWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use CerberusWeb, :controller` and
  `use CerberusWeb, :live_view`.
  """
// New line added 2024-09-22T19:21:29.117Z
  use CerberusWeb, :html

  embed_templates "layouts/*"
end

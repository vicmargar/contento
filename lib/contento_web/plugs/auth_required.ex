defmodule ContentoWeb.Plug.AuthRequired do
  use Guardian.Plug.Pipeline, otp_app: :contento

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
  plug ContentoWeb.Plug.CheckUser
  plug ContentoWeb.Plug.PasswordSetup
end

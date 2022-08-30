defmodule Memorilo.Service.GoogleApi do
  use Tesla
  require Logger

  plug Tesla.Middleware.BaseUrl, api_credentials()[:base_url]
  plug Tesla.Middleware.Headers, [{"Content-Type", "application/json"}]
  plug Tesla.Middleware.JSON

  def get_fresh_token() do
    with {:ok, response} <- post(api_credentials()[:route], body()),
      %{"access_token" => token} <- response.body do
        {:ok, token}
      else
        error -> Logger.error("failed_to_get_fresh_token: #{inspect(error)}")
          {:error, :failed_to_get_fresh_token}
      end
  end

  defp api_credentials do
    Application.get_env(:memorilo, :google_api)
  end

  defp body do
    api_credentials()
    |> Enum.into(%{})
    |> Map.take([:client_id, :client_secret, :refresh_token, :grant_type])
  end
end

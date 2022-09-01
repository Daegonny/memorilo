defmodule Memorilo.Mail.Mailer do
  @moduledoc false
  use Swoosh.Mailer, otp_app: :memorilo
  import Swoosh.Email
  alias Memorilo.Service.GoogleApi

  def build_message(to, subject, content) do
    new()
    |> to(to)
    |> from({"Memorilo", "memorilo.app@gmail.com"})
    |> subject(subject)
    |> text_body(content)
  end
 def send(message) do
    with {:ok, token} <- GoogleApi.get_fresh_token() do
      deliver(message, access_token: token)
    end
  end
end

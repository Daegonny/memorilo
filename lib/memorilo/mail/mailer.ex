defmodule Memorilo.Mail.Mailer do
  @moduledoc false
  use Swoosh.Mailer, otp_app: :memorilo
  import Swoosh.Email
  alias Memorilo.Service.GoogleApi

  @name "Memorilo"
  @email "memorilo.app@gmail.com"

  def build_message(subject, content, to) do
    new()
    |> to(to)
    |> from({@name, @email})
    |> subject(subject)
    |> text_body(content)
  end

  def send(message) do
    with {:ok, token} <- GoogleApi.get_fresh_token() do
      deliver(message, access_token: token)
    end
  end
end

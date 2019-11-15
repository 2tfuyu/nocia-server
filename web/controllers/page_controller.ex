defmodule NociaServer.PageController do
  use NociaServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def push(conn, %{"message" => message}) do
    url = "https://fcm.googleapis.com/fcm/send"
    api_key = ""
    registration_ids = [""]

    headers = [{"Content-Type", "application/json"},
      {"Authorization", "key=#{api_key}"}]

    json_data = %{collapse_key: "ff1",
                  delay_while_idle: true,
                  time_to_live: 864000,
                  notification: %{title: "nocia", body: message},
                  registration_ids: registration_ids} |> Poison.encode!

    response = HTTPoison.post!(url,  json_data, headers)

    # IO.puts response.body

    case response do
      %{status_code: 200, body: body} -> json conn, Poison.decode!(body)
      %{status_code: code} -> json conn, %{error: code}
    end
  end
end

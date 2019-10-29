defmodule KuehlschrankWeb.WebhookController do
  use KuehlschrankWeb, :controller
  alias Kuehlschrank.Image
  alias Kuehlschrank.Repo

  use HTTPoison.Base

  def create(conn, params) do
    handle_message(params["message"])

    json(conn, %{ok: :true})
  end

  def handle_message(%{"photo" => photo, "from" => from}) do
    handle_photo(photo, from)
  end

  def handle_message(_message) do
    # no photo do nothing, but log
    IO.inspect "message without photo"
  end

  def handle_photo([], _from) do
  end

  def handle_photo([photo | tail], from) do
    file_path = lookup_file_path(photo)

    changeset = Image.changeset(%Image{}, %{
      handle: "https://api.telegram.org/file/#{Application.get_env(:kuehlschrank, :telegram_bot)}/#{file_path}",
      first_name: from["first_name"]
    })

    if changeset.valid? do
      Repo.insert(changeset)
    end

    handle_photo(tail, from)
  end

  def lookup_file_path(%{"file_id" => file_id}) do
    url = "https://api.telegram.org/#{Application.get_env(:kuehlschrank, :telegram_bot)}/getFile?file_id=#{file_id}"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)["result"]["file_path"]
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect "could not load photo details from #{url} b/c #{reason}"
    end
  end

end

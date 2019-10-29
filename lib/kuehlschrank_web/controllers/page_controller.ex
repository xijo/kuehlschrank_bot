defmodule KuehlschrankWeb.PageController do
  use KuehlschrankWeb, :controller

  import Ecto.Query

  alias Kuehlschrank.Repo
  alias Kuehlschrank.Image

  def index(conn, _params) do
    image = Image |> last |> Repo.one
    render(conn, "index.html", image: image)
  end
end

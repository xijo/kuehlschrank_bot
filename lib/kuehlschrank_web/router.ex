defmodule KuehlschrankWeb.Router do
  use KuehlschrankWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KuehlschrankWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/telegram", KuehlschrankWeb, as: :telegram do
    pipe_through :api

    resources "/webhook", WebhookController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", KuehlschrankWeb do
  #   pipe_through :api
  # end
end

defmodule NociaServer.Router do
  use NociaServer.Web, :router

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


  scope "/", NociaServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  #Other scopes may use custom stacks.
  scope "/api", NociaServer do
    pipe_through :api
    get "/push/:message", PageController, :push
  end
end

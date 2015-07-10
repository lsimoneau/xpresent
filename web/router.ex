defmodule Xpresent.Router do
  use Xpresent.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Xpresent do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/decks", DeckController do
      resources "slides", SlideController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Xpresent do
  #   pipe_through :api
  # end
end

defmodule Xpresent.DeckController do
  use Xpresent.Web, :controller

  alias Xpresent.Deck

  plug :scrub_params, "deck" when action in [:create, :update]

  def index(conn, _params) do
    decks = Repo.all(Deck)
    render(conn, "index.html", decks: decks)
  end

  def new(conn, _params) do
    changeset = Deck.changeset(%Deck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deck" => deck_params}) do
    changeset = Deck.changeset(%Deck{}, deck_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Deck created successfully.")
      |> redirect(to: deck_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id) |> Repo.preload [:slides]
    render(conn, "show.html", deck: deck)
  end

  def edit(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id)
    changeset = Deck.changeset(deck)
    render(conn, "edit.html", deck: deck, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deck" => deck_params}) do
    deck = Repo.get!(Deck, id)
    changeset = Deck.changeset(deck, deck_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Deck updated successfully.")
      |> redirect(to: deck_path(conn, :index))
    else
      render(conn, "edit.html", deck: deck, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id)
    Repo.delete!(deck)

    conn
    |> put_flash(:info, "Deck deleted successfully.")
    |> redirect(to: deck_path(conn, :index))
  end
end

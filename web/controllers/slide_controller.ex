defmodule Xpresent.SlideController do
  use Xpresent.Web, :controller

  alias Xpresent.Slide

  def new(conn, %{"deck_id" => deck_id}) do
    changeset = Slide.changeset(%Slide{deck_id: deck_id})
    render(conn, "new.html", changeset: changeset, deck_id: deck_id)
  end

  def create(conn, %{"slide" => slide_params, "deck_id" => deck_id}) do
    changeset = Slide.changeset(%Slide{}, Dict.merge(slide_params, %{"deck_id" => deck_id}))

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Slide created successfully.")
      |> redirect(to: deck_path(conn, :show, deck_id))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end
end

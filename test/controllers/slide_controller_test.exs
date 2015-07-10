defmodule Xpresent.SlideControllerTest do
  use Xpresent.ConnCase

  alias Xpresent.Deck
  alias Xpresent.Slide
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "renders form for new slide", %{conn: conn} do
    deck = Repo.insert! %Deck{name: "Example deck"}
    conn = get conn, deck_slide_path(conn, :new, deck)
    assert html_response(conn, 200) =~ "New slide"
  end

  test "creates slide and redirects when data is valid", %{conn: conn} do
    deck = Repo.insert! %Deck{name: "Example deck"}
    conn = post conn, deck_slide_path(conn, :create, deck), slide: @valid_attrs
    assert redirected_to(conn) == deck_path(conn, :show, deck)
    assert Repo.get_by(Slide, %{deck_id: deck.id, content: "some content"})
  end
end

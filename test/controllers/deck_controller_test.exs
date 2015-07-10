defmodule Xpresent.DeckControllerTest do
  use Xpresent.ConnCase

  alias Xpresent.Deck
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, deck_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing decks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, deck_path(conn, :new)
    assert html_response(conn, 200) =~ "New deck"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, deck_path(conn, :create), deck: @valid_attrs
    assert redirected_to(conn) == deck_path(conn, :index)
    assert Repo.get_by(Deck, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, deck_path(conn, :create), deck: @invalid_attrs
    assert html_response(conn, 200) =~ "New deck"
  end

  test "shows chosen resource", %{conn: conn} do
    deck = Repo.insert! %Deck{name: "Example deck"}
    conn = get conn, deck_path(conn, :show, deck)
    assert html_response(conn, 200) =~ "Example deck"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, deck_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    deck = Repo.insert! %Deck{}
    conn = get conn, deck_path(conn, :edit, deck)
    assert html_response(conn, 200) =~ "Edit deck"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    deck = Repo.insert! %Deck{}
    conn = put conn, deck_path(conn, :update, deck), deck: @valid_attrs
    assert redirected_to(conn) == deck_path(conn, :index)
    assert Repo.get_by(Deck, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    deck = Repo.insert! %Deck{}
    conn = put conn, deck_path(conn, :update, deck), deck: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit deck"
  end

  test "deletes chosen resource", %{conn: conn} do
    deck = Repo.insert! %Deck{}
    conn = delete conn, deck_path(conn, :delete, deck)
    assert redirected_to(conn) == deck_path(conn, :index)
    refute Repo.get(Deck, deck.id)
  end
end

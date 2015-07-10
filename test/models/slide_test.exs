defmodule Xpresent.SlideTest do
  use Xpresent.ModelCase

  alias Xpresent.Slide

  @valid_attrs %{content: "some content", deck: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Slide.changeset(%Slide{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Slide.changeset(%Slide{}, @invalid_attrs)
    refute changeset.valid?
  end
end

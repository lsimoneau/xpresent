defmodule Xpresent.PresentationTest do
  alias Xpresent.Presentation
  use ExUnit.Case, async: true

  test "starts on the first slide" do
    {:ok, presentation} = Presentation.start_link
    assert Presentation.current_slide(presentation) == 1
  end

  test "it can go forward a slide" do
    {:ok, presentation} = Presentation.start_link
    Presentation.next_slide(presentation)

    assert Presentation.current_slide(presentation) == 2
  end

  test "it can go backward a slide" do
    {:ok, presentation} = Presentation.start_link
    Presentation.next_slide(presentation)
    Presentation.next_slide(presentation)
    assert Presentation.current_slide(presentation) == 3

    Presentation.prev_slide(presentation)
    assert Presentation.current_slide(presentation) == 2
  end
end

defmodule Xpresent.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = Xpresent.Registry.start_link
    {:ok, registry: registry}
  end

  test "it starts presentations", %{registry: registry} do
    assert Xpresent.Registry.lookup(registry, "foo") == :error

    name = Xpresent.Registry.start_presentation(registry, 1)
    assert { :ok, pres } = Xpresent.Registry.lookup(registry, name)

    Xpresent.Presentation.next_slide(pres)
    assert Xpresent.Presentation.current_slide(pres) == 2
  end

  test "removes presentations on exit", %{registry: registry} do
    name = Xpresent.Registry.start_presentation(registry, 1)
    {:ok, pres} = Xpresent.Registry.lookup(registry, name)
    Agent.stop(pres)
    assert Xpresent.Registry.lookup(registry, name) == :error
  end
end

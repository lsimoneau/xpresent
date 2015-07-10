defmodule Xpresent.Presentation do
  def start_link do
    Agent.start_link(fn -> 1 end)
  end

  def current_slide(pres) do
    Agent.get(pres, &(&1))
  end

  def next_slide(pres) do
    Agent.update(pres, &(&1 + 1))
  end

  def prev_slide(pres) do
    Agent.update(pres, &(&1 - 1))
  end
end

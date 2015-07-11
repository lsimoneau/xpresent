defmodule Xpresent.Registry do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def start_presentation(server, deck_id) do
    GenServer.call(server, {:start_presentation, deck_id})
  end

  ## Server callbacks

  def init(:ok) do
    { :ok, HashDict.new }
  end

  def handle_call({:lookup, name}, _from, dict) do
    case HashDict.fetch(dict, name) do
      :error -> { :reply, :error, dict }
      {:ok, pres} -> { :reply, {:ok, pres.process}, dict }
    end
  end

  def handle_call({:start_presentation, deck_id}, _from, dict) do
    name = new_name(dict)
    {:ok, process} = Xpresent.Presentation.start_link
    new_state = HashDict.put(dict, name, %Xpresent.Presentation{deck_id: deck_id, process: process})
    {:reply, name, new_state}
  end

  defp new_name(dict) do
    name = SecureRandom.urlsafe_base64(5)
    if HashDict.has_key?(dict, name) do
      new_name(dict)
    else
      name
    end
  end
end

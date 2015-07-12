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
    names = HashDict.new
    refs = HashDict.new
    { :ok, {names,refs} }
  end

  def handle_call({:lookup, name}, _from, {names, _} = state) do
    case HashDict.fetch(names, name) do
      :error -> { :reply, :error, state }
      {:ok, pres} -> { :reply, {:ok, pres.process}, state }
    end
  end

  def handle_call({:start_presentation, deck_id}, _from, {names, refs}) do
    name = new_name(names)
    {:ok, pid} = Xpresent.Presentation.start_link
    ref = Process.monitor(pid)
    refs = HashDict.put(refs, ref, name)
    names = HashDict.put(names, name, %Xpresent.Presentation{deck_id: deck_id, process: pid})
    {:reply, name, {names, refs}}
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    { name, refs } = HashDict.pop(refs, ref)
    names = HashDict.delete(names, name)
    {:noreply, {names,refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
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

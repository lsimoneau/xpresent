defmodule Xpresent.Repo.Migrations.CreateSlide do
  use Ecto.Migration

  def change do
    create table(:slides) do
      add :content, :text
      add :deck_id, :integer

      timestamps
    end
    create index(:slides, [:deck_id])

  end
end

defmodule Bell.Repo.Migrations.CreateRings do
  use Ecto.Migration

  def change do
    create table(:rings) do
      timestamps()
    end
  end
end

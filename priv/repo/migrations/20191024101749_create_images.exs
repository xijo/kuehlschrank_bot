defmodule Kuehlschrank.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :handle, :string
      add :sent_at, :utc_datetime
      add :first_name, :string
      add :last_name, :string
      add :text, :string
      add :message_id, :integer

      timestamps()
    end

  end
end

defmodule Kuehlschrank.Image do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :first_name, :string
    field :handle, Kuehlschrank.Handle.Type
    field :last_name, :string
    field :message_id, :integer
    field :sent_at, :utc_datetime
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:sent_at, :first_name, :last_name, :text, :message_id])
    |> cast_attachments(attrs, [:handle], allow_paths: true)
    |> validate_required([:handle, :first_name])
  end
end

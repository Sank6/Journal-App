defmodule Journal.TimelineTest do
  use Journal.DataCase

  alias Journal.Timeline

  describe "entries" do
    alias Journal.Timeline.Entry

    @valid_attrs %{body: "some body", feeling: "some feeling", image: "some image", time: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{body: "some updated body", feeling: "some updated feeling", image: "some updated image", time: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{body: nil, feeling: nil, image: nil, time: nil, title: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Timeline.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Timeline.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Timeline.create_entry(@valid_attrs)
      assert entry.body == "some body"
      assert entry.feeling == "some feeling"
      assert entry.image == "some image"
      assert entry.time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert entry.title == "some title"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Timeline.update_entry(entry, @update_attrs)
      assert entry.body == "some updated body"
      assert entry.feeling == "some updated feeling"
      assert entry.image == "some updated image"
      assert entry.time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert entry.title == "some updated title"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_entry(entry, @invalid_attrs)
      assert entry == Timeline.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Timeline.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Timeline.change_entry(entry)
    end
  end
end

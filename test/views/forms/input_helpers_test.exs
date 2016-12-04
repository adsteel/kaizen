defmodule Kaizen.Forms.InputHelpersTest do
  import Kaizen.Forms.InputHelpers

  use Kaizen.ConnCase, async: true

  alias Kaizen.User

  @data %User{username: "username"}
  @valid_form %Phoenix.HTML.Form{data: @data}
  @extra_spaces ~r/[ ]{2,}/

  test "#form_textarea" do
    textarea = form_textarea(@valid_form, :username) |> as_markup

    expected = """
               <div class="form-group ">
                 <label class="control-label" for="_username">Username</label>
                 <textarea class="form-control" id="_username" name="[username]">
                   username
                 </textarea>
               </div>
               """ |> sanitize_markup

    assert textarea == expected
  end

  test "#form_select" do
    select = form_select(@valid_form, :username, options: [1, 2, 3]) |> as_markup

    expected = """
               <div class="form-group ">
                 <label class="control-label" for="_username">Username</label>
                 <select class="form-control" id="_username" name="[username]">
                   <option value="1">1</option>
                   <option value="2">2</option>
                   <option value="3">3</option>
                 </select>
               </div>
               """ |> sanitize_markup

    assert select == expected
  end

  defp as_markup(tuples) do
    tuples
      |> Phoenix.HTML.Safe.to_iodata
      |> IO.iodata_to_binary
      |> sanitize_markup
  end

  defp sanitize_markup(markup) do
    markup
      |> String.replace(@extra_spaces, "")
      |> String.replace("\n", "")
  end
end

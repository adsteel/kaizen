defmodule Kaizen.Forms.InputHelpers do
  use Phoenix.HTML

  def form_text_input(form, field) do
    input_tag(form, field, :text_input, [form, field])
  end

  def form_textarea(form, field) do
    input_tag(form, field, :textarea, [form, field])
  end

  def form_select(form, field, opts \\ []) do
    input_tag(form, field, :select, [form, field, opts[:options]])
  end

  def form_submit(value) do
    content_tag :div, [class: "form-group"] do
      Phoenix.HTML.Form.submit value, [class: "btn btn-primary"]
    end
  end

  defp input_tag(form, field, type, input_opts \\ []) do
    wrapper_opts = [class: "form-group #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    input_class_opts = [class: "form-control"]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input = apply(Phoenix.HTML.Form, type, input_opts ++ [input_class_opts])
      error = Kaizen.ErrorHelpers.error_tag(form, field) || ""

      [label, input, error]
    end
  end

  defp state_class(form, field) do
    cond do
      form.errors[field] -> "has-error"
      true -> ""
    end
  end
end

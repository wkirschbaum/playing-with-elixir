defmodule Play.MarkupTest do
  use ExUnit.Case

  import Play.Markup

  test "basic basic div" do
    ast =
      markup do
        form do
          for num <- [1, 2, 5] do
            span class: "foo #{num}" do
              text("bar #{num}")
            end

            html do
              text("foo")
            end

            bar style: "foo" do
              text("what")
            end
          end

          span class: "foo" do
            text("bar")
          end
        end
      end

    assert ast == ""
  end
end
